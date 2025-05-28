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

if button_pressed(inputs.dash) && is_targeting() && current_spell.can_cancel {
	spell_clear()
}

if is_targeting() {
	var spell = current_spell;
	spell.active_step();
	
	if (point_in_bbox(mouse_x, mouse_y, Board)) {
		// Left Click
		if button_pressed(inputs.shoot) {
			clicked = true;
			clicked_x = mouse_x;
			clicked_y = mouse_y;
			spell.on_click();
		}
		else {
			if !button_check(inputs.shoot) {
				clicked = false
				spell.on_release()
			}
			else {
				spell.on_hold(clicked_x, clicked_y);
				clicked_x = mouse_x;
				clicked_y = mouse_y;
			}
		}
	}
	else {
		clicked = false
	}
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