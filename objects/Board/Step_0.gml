/// @description Editor Code

if become_active > 0 {
	become_active -= 1
	if become_active == 0 {
		active = true
	}
}

//trace(string("{0}, {1}", ceil((bbox_left + bbox_right)/2), (bbox_bottom)))

//Toggle Editor
if keyboard_check_pressed(vk_home) {
	editor = !editor;
	//Disable editor
	if !editor {
		update_current_level()
		global.round = 0
		round_start()
		
		global.editor_buttons.for_each_object(function(i) {
			i.visible = false
		})
		
		update_battler_bricks()
		
		with obj_cuffs visible = true;
	}
	//Enable editor
	else{
		with(par_collectible) instance_destroy(self, false);
		with(Ball) instance_destroy(self, false);
		
		global.editor_buttons.for_each_object(function(i) {
			i.visible = true
		})
		
		//with(par_bricklike) instance_destroy(self, false);
		level_clear()
		level_load(global.level_num)
		with EnemyBattler {
			go_to(1088, 256 + 128 * enemy_position)
		}
		
		with obj_cuffs visible = false;
	}
	with par_bricklike event_perform(ev_other, ev_user15);

}

if(editor){
	with(par_collectible) instance_destroy(self, false);
	
	// Paint mode toggle
	if button_pressed(inputs.editor_color_mode) {
		if mode == editorMode.paint {
			sound_play_random(sndSwitch2, 1, .3)
			exit_paint_mode()
		}
		else {
			sound_play_random(sndSwitch1, 2, .3)
			enter_paint_mode()
		}
	}
	
	if mode = editorMode.build {
		var scroll = mouse_wheel_down() - mouse_wheel_up();
		if scroll != 0 {
			current_placer().reset();
			placer_index = array_wrap_index(placers, placer_index + scroll)
		}
		var rotate = button_pressed(inputs.turn_right) - button_pressed(inputs.turn_left);
		if rotate != 0 {
			current_placer().cycle(rotate);
		}
		
		//Block pick
		if mouse_check_button_pressed(mb_middle) {
			var inst = instance_position(mouse_x, mouse_y, parBoardObject);
			if instance_exists(inst) {
				var index = array_find_index(placers,
					method(inst, function(placer) {
						return placer.try_match(self)
					})
				);
				if index != -1 placer_index = index;
			}
		}
		
		var placer = current_placer();
		if point_in_bbox(mouse_x, mouse_y, self) {
			if button_pressed(inputs.shoot) {
				clicked = true;
				clicked_x = mouse_x;
				clicked_y = mouse_y;
				placer.on_click();
				
			}
			else {
				if !button_check(inputs.shoot) {
					clicked = false
					placer.on_release()
				}
				else {
					placer.on_hold(clicked_x, clicked_y);
					clicked_x = mouse_x;
					clicked_y = mouse_y;
				}
			}
			if button_pressed(inputs.dash) {
				right_clicked = true;
				right_clicked_x = mouse_x;
				right_clicked_y = mouse_y;
				placer.on_right_click();
				
			}
			else {
				if !button_check(inputs.dash) {
					right_clicked = false
					placer.on_right_click_release()
				}
				else {
					placer.on_right_click_hold(right_clicked_x, right_clicked_y);
					right_clicked_x = mouse_x;
					right_clicked_y = mouse_y;
				}
			}
		}
		else {
			if clicked clicked = false;
			if right_clicked right_clicked = false;
		}
	}
	
	
	if mode = editorMode.paint {
		var scroll = mouse_wheel_down() - mouse_wheel_up();
		if scroll != 0 {
			var maxcol = button_check(inputs.editor_modifier) ? COLORS.MAX : (COLORS.YELLOW + 1);
			paintcolor = wrap(paintcolor + scroll, -1, maxcol)
			enter_paint_mode()
			sound_play_random(sndSwitch1, 2, .3)
		}
		
		var n = instance_nearest(mouse_x, mouse_y, parBoardObject);
		if instance_exists(n) && distance_to_bbox(mouse_x, mouse_y, n) < 10 && n.colorable {
			// Color bricks
			if (button_check(inputs.shoot) || button_check(inputs.mouse_right)) {
				var col = button_check(inputs.shoot) ? paintcolor : -1;
				if n.color != col {
					n.set_color(col)
					mark_level_changed()
					sound_play_random(sound_pool(sndColor1))
				}
			}
			// Color pick
			if mouse_check_button_pressed(mb_middle) {
				sound_play_random(sndSwitch1, 2, .3)
				enter_paint_mode(n.color)
			}
		}
	}
	
	
	if button_pressed(inputs.editor_translate_down) {
		with parBoardObject {
			y += TILE_HEIGHT
		}
		mark_level_changed()
	}
	if button_pressed(inputs.editor_translate_up) {
		with parBoardObject {
			y -= TILE_HEIGHT
		}
		mark_level_changed()
	}
	
	//Delete all board elements
	if button_pressed(inputs.editor_clear){
		level_clear()
		mark_level_changed()
	}
	
	//New Level
	if button_pressed(inputs.editor_new) {
		level_clear()
		
		add_new_level()
		level_load(array_length(global.level_data) - 1)
	}
	
	//Reload level from file
	if button_pressed(inputs.editor_reload) && current_level.info.name != "" {
		level_clear()
		current_level = load_level_file(current_level.info.name + ".txt")
		mark_level_changed(false)
		level_load(global.level_num)
	}
	
	//Save Level
	if button_pressed(inputs.editor_save){
		save_current_level()
	}
	
	//Cycle through loaded levels
	if button_pressed(inputs.editor_cycle) {
		if global.level_changed[global.level_num] {
			update_current_level()
		}
		level_clear()
		board_cycle(button_pressed(inputs.editor_left) ? -1 : 1)
	}
}