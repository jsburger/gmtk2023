/// @description 
event_inherited();

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
current_action = undefined;

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

bump_action = function() {
	current_action = get_next_action()
	current_action.on_move_decided()
}
battle_start_hook = function(){}
battle_start = function() {
	battle_start_hook()
	if current_action = undefined {
		bump_action()
	}
}

turn = function() {
	if current_action != undefined current_action.act()
	current_action = undefined
}

turn_end = function() {
	__turn_end()
	if current_action = undefined {
		//bump_action()
	}
}

CombatRunner.add_enemy_instance(self)