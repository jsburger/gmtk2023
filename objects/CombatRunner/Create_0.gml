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
targeted_enemy = 0;

waitTime = 0;
acting = false;

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