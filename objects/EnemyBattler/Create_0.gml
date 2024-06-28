/// @description 
event_inherited();

//Non Combat stuff
lerp_x = x;
lerp_y = y;
go_to = function(_x, _y) {
	lerp_x = _x;
	lerp_y = _y;
}


//Combat stuff
spr_icon = sprGaySquirrelIcon

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

decide_actions = function() {
	clear_actions()
	while array_length(current_actions) < move_max {
		array_push(current_actions, get_next_action().clone());
	}
	for_each_action(function(act) {
		act.on_move_decided()
	})
	Timeline.update()
}
reroll_actions = function(count) {
	repeat(count) {
		var index = irandom(array_length(current_actions) - 1);
		current_actions[index] = get_next_action().clone();
		current_actions[index].on_move_decided();
	}
	Timeline.update()
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