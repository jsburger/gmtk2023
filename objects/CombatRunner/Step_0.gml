/// @description 


with PlayerBattler other.player = self

if waitTime > 0 {
	waitTime -= 1
}

//Run enemy turn
while !is_busy() && !is_player_turn && !waitForPlayer {
	if array_length(enemies) > 0
		do_phase_action(enemies[phaseProgress])
	if ++phaseProgress >= array_length(enemies) {
		phaseProgress = 0
		phase++
			
		if phase > PHASES.END {
			phase = PHASES.BEGIN
			waitForPlayer = true
			run_round_end = true;
			break
		}
	}
}

// Run board object scripts after enemy attacks are completely resolved
if run_round_end && !is_busy() {
	run_round_end = false;
	with parBoardObject if on_round_end != undefined {
		on_round_end()
	}
}

if is_player_turn && current_ability != undefined && !targeting {
	run_ability()
}

if button_pressed(inputs.dash) && targeting == true && current_ability != undefined && current_ability.can_cancel {
	cancel_targeting()
}

if current_ability != undefined && targeting {
	current_ability.on_target_step();
}

//Resolve items added by actions
acting = true
while has_actions() && waitTime <= 0 {
	if array_length(actions) > 0 {
		var action = actions[0];
		action.act(self);
		action.progress += 1;
	}
	progress_actions();
}
acting = false

//once actions are resolved, start player turn
if !is_busy() && waitForPlayer == true && !combat_ending {
	waitForPlayer = false
	is_player_turn = true
	round_end()
}