/// @description 

enum PHASES {
	BEGIN,
	TURN,
	END
}

actions = [];
resolving_actions = [];

is_player_turn = true;
phase = PHASES.BEGIN
phaseProgress = 0
waitForPlayer = false

player = noone;
enemies = [];
current_enemy = 0;
current_actor = noone;
targeted_enemy = 0;

waitTime = 0;
acting = false;

current_ability = undefined;
targeting = false;

combat_started = false;

mount_ability = function(ability) {
	current_ability = ability
	targeting = ability.needs_target
	if !targeting {
		run_ablity()
	}
}

run_ability = function() {
	current_actor = PlayerBattler.id;
	current_ability.act();
	current_abiltiy.spend_mana();
	current_ability = undefined;
}

enqueue = function(action) {
	if acting {
		array_push(resolving_actions, action)
	}
	else {
		array_push(actions, action)
	}
}

has_actions = function() {
	return array_length(actions) > 0 || array_length(resolving_actions) > 0
}

is_busy = function() {
	return has_actions() || waitTime > 0;
}

do_phase_action = function(target) {
	current_enemy = phaseProgress
	current_actor = target
	if target.canact == false exit
	if phase == PHASES.BEGIN {
		target.turn_start()
	}
	if phase == PHASES.TURN {
		target.turn()
	}
	if phase == PHASES.END {
		target.turn_end()
	}
}

add_enemy = function(enemyObj) {
	with instance_create_layer(0, 0, "Instances", enemyObj) {
		//if other.combat_started {
		//	battle_start();
		//}
		array_push(other.enemies, self)
		enemy_position = array_length(other.enemies)
		
		return self
	}
}

remove_enemy = function(index) {
	with enemies[index] {
		instance_destroy()
	}
	
	for (var i = index + 1; i < array_length(enemies); i++) {
		enemies[i].enemy_position -= 1
	}
	
	array_delete(enemies, index, 1)
	if phaseProgress >= index phaseProgress -= 1
	
}