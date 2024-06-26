/// @description 


with PlayerBattler other.player = self

if waitTime > 0 {
	waitTime -= 1
}

//Run enemy turn
while !is_busy() && !is_player_turn && !waitForPlayer {
	do_phase_action(enemies[phaseProgress])
	if ++phaseProgress >= array_length(enemies) {
		phaseProgress = 0
		phase++
			
		if phase > PHASES.END {
			phase = PHASES.BEGIN
			waitForPlayer = true
			break
		}
	}
}

if is_player_turn && current_ability != undefined && !targeting {
	run_ability()
}

if button_pressed(inputs.dash) && targeting == true && current_ability != undefined && current_ability.can_cancel {
	cancel_targeting()
}

//Resolve items added by actions
acting = true
while has_actions() && waitTime <= 0 {
	//Resolve actions
	if array_length(resolving_actions) > 0 {
		var action = array_shift(resolving_actions);
		action.act(self);
		waitTime += action.delay;
	}
	//Must have actions
	else {
		if array_length(actions) > 0 {
			//Move actions to resolve queue
			array_push(resolving_actions, array_shift(actions))
		}
		else {
			acting = false
			array_shift(move_queue).act()
			Timeline.update(false)
			acting = true
		}
	}
}
acting = false

//once actions are resolved, start player turn
if !is_busy() && waitForPlayer == true && !combat_ending {
	waitForPlayer = false
	is_player_turn = true
	round_end()
}