/// @description 
event_inherited();

enum ENEMY_SIZE {
	SMALL,
	NORMAL
}

mask_index = sprEnemyFrame;

//Non Combat stuff
lerp_x = x;
lerp_y = y;
go_to = function(_x, _y) {
	lerp_x = _x;
	lerp_y = _y;
}

extra_objects = []; //Used by the Editor to get associated objects.

//Combat stuff
spr_icon = sprGayLittleSquirrelIcon

spr_frame = sprEnemyFrame;
spr_bg = sprEnemyBg;

size = ENEMY_SIZE.NORMAL;
bg_color = c_red;
show_owner = false;

#region Deprecated?
can_click = function() {
	if instance_exists(CombatRunner) {
		return CombatRunner.targeting
	}	
	return false
}

on_click = function() {
	CombatRunner.targeted_enemy = enemy_position
	CombatRunner.targeting = false
}
#endregion

enemy_position = 0

actions = [];
has_shuffled = false;
shuffled = [];

enum moveOrder {
	RANDOM, //truly random
	RANDOM_STACK, //random but uses all moves once and then resets
	LINEAR // uses all moves in order
}

movemode = moveOrder.RANDOM
moveProgress = 0;
current_actions = [];
move_max = 1;
move_rerolls = 0;

/// @returns {Struct.EnemyMove}
get_next_action = function() {
	switch(movemode) {
		case moveOrder.RANDOM:
			return array_random(actions)
		case moveOrder.LINEAR:
			return actions[moveProgress++ mod array_length(actions)];
		case moveOrder.RANDOM_STACK:
			if !has_shuffled || moveProgress >= array_length(actions) {
				shuffled = array_shuffle(actions)
				has_shuffled = true
				moveProgress = 0
			}
			return shuffled[moveProgress++]
	}
}
/// @param {Struct.MoveFactory} move
mount_move = function(move) {
	var act = move.get();
	array_push(current_actions, act);
	act.on_move_decided();	
}

decide_actions = function() {
	clear_actions()
	while array_length(current_actions) < move_max {
		array_push(current_actions, get_next_action().get());
	}
	for_each_action(function(act) {
		act.on_move_decided()
	})
	Timeline.update()
}
reroll_actions = function(count) {
	var indices = random_numbers(array_length(current_actions), array_length(current_actions));
	var n = 0;
	for (var i = 0; n < count && i < array_length(indices); i++) {
		var index = indices[i];
		if current_actions[index].is_rerollable {
			n += 1;
			current_actions[index] = get_next_action().get();
			current_actions[index].on_move_decided();
		}
	}
	Timeline.update()
}

/// @param {Struct.DamageInfo} info
/// @desc Called in hurt() to run enemy specific logic. Do not override.
/// @ignore
enemy_hurt = function(info) {
	if info.unblocked_damage > 0 {
		if move_rerolls > 0 {
			reroll_actions(min(move_rerolls, move_max))
		}
	}
}

for_each_action = function(func) {
	array_foreach(current_actions, func)
}
has_actions = function() {
	return array_length(current_actions) > 0;
}
clear_actions = function() {
	current_actions = [];
}
run_actions = function() {
	for_each_action(function(action) {		
		CombatRunner.enqueue_move(action)
	})
}


battle_start_hook = function(){}
battle_start = function() {
	battle_start_hook()
	if !has_actions() {
		decide_actions()
	}
}

turn = function() {
	run_actions()
	clear_actions()
}

/// Used by CombatRunner after an enemy is spawned as part of an encounter
after_create = function() {}