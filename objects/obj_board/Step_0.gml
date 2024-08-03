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
	}
	with par_bricklike event_perform(ev_other, ev_user15);

}

if(editor){
	with(par_collectible) instance_destroy(self, false);
	
	if mode = editorMode.build {
		entity_subnum += button_pressed(inputs.turn_right) - button_pressed(inputs.turn_left);

		if mouse_wheel_up(){
			entity_num --;
			if entity_num < 0 entity_num = array_length(entity_list) - 1;
			entity_subnum = 0;
		}
		if mouse_wheel_down(){
			entity_num ++;
			if entity_num >= array_length(entity_list) entity_num = 0;
			entity_subnum = 0;
		}
		
		
		//Block pick
		if mouse_check_button_pressed(mb_middle) {
			var inst = instance_position(mouse_x, mouse_y, parBoardObject);
			if instance_exists(inst) {
				for (var i = 0; i < array_length(entity_list); i++) {
					for (var o = 0; o < array_length(entity_list[i]); o++) {
						if entity_list[i][o] == inst.object_index {
							entity_num = i;
							entity_subnum = o;
						}
					}
				}
			}
		}
	
		if entity_subnum < 0 entity_subnum = (array_length(entity_list[entity_num]) - 1);
		if entity_subnum > (array_length(entity_list[entity_num]) - 1) entity_subnum = 0;
	
		var _entity = entity_list[entity_num][entity_subnum],
			_sprite = object_get_sprite(_entity),
			mask = object_get_mask(_entity);
		if mask == -1 mask = _sprite;
		current_entity = _entity;
		current_sprite = _sprite;
	
		var pos = board_grid_position(mouse_x, mouse_y),
			right = sprite_get_bbox_right(  mask) + 1,
			left  = sprite_get_bbox_left(   mask),
			top   = sprite_get_bbox_top(    mask),
			bottom = sprite_get_bbox_bottom(mask) + 1,
			xoff = sprite_get_xoffset(mask),
			yoff = sprite_get_yoffset(mask);
		mx = clamp(pos.x + (xoff mod TILE_MIN), bbox_left + TILE_MIN + (xoff - left), bbox_right - TILE_MIN - (right - xoff));
		my = clamp(pos.y + (yoff mod TILE_MIN), bbox_top + TILE_MIN + (yoff - top), bbox_bottom - TILE_MIN - (bottom - yoff));
		//mx += (sprite_get_xoffset(_sprite) mod TILE_MIN);
		//my += (sprite_get_yoffset(_sprite) mod TILE_MIN);
		
		var _place = other.entity_list[other.entity_num][other.entity_subnum];
		obj_layer = object_get_parent(_place) == obj_cable ? 1 : 0;
	
		if point_in_bbox(mouse_x, mouse_y, self) {
			//Collision
			with instance_create_layer(mx, my, layer, obj_placer){
				//obj_placer handels the canplace variable
				mask_index = mask;
		
				//Lazy fix, sorry:
				if _sprite == sprBall {	
					_sprite = sprBomb;
					mask_index = _sprite;
				}
				sprite_index = _sprite;
		
				other.canplace = true;
				var _list = ds_list_create(),
					 _num = instance_place_list(x, y, par_bricklike, _list, false);
				if _num > 0{
				    for (var i = 0; i < _num; ++i){
				       if _list[| i].obj_layer == other.obj_layer{
						   _list[| i].blocking = true;
							obj_board.canplace = false;   
						}
				    }
				}
				ds_list_destroy(_list);
				if place_meeting(x, y, parBoardObject) other.canplace = false;
				instance_destroy();
			}

			//Place bricks
			if button_check(inputs.shoot){
				if canplace{
					sound_play_pitch(sndDieHitBrick, random_range(1.7, 3));
			
					with instance_create_layer(mx,my,"Instances",_entity){
						obj_layer = other.obj_layer;
				
						var _factor = (sprite_width * sprite_height) / (TILE_MIN * 8);
				
						repeat(floor(_factor)) with instance_create_depth(x, y, depth + 21 * choose(1, 1, 1, -1), obj_dust){
							motion_add(random(360), random_range(3, 6) * (1 + _factor / 40));
							friction = random_range(.35, .2) * (1 + _factor / 40);
							image_speed *= random_range(.8, 1);
						}
					}
					mark_level_changed()
				}
			}
			//Delete bricks
			if button_check(inputs.mouse_right){
				with instance_create_layer(mx, my, layer, obj_placer){
					mask_index = _sprite;
					sprite_index = mask_index;
			
					var _list = ds_list_create(),
						 _num = instance_place_list(x, y, par_bricklike, _list, false);
					if _num > 0{
					    for (var i = 0; i < _num; ++i){
					       if _list[| i].obj_layer == obj_board.obj_layer{
					   
							   var _factor = (_list[| i].sprite_width * _list[| i].sprite_height) / (TILE_MIN * 8);
							   repeat(3 + _factor) with instance_create_depth(x, y, depth + 21 * choose(1, 1, 1, -1), obj_dust){
									motion_add(random(360), random_range(3, 6) * (1 + _factor / 40));
									friction = random_range(.35, .2) * (1 + _factor / 40);
									image_speed *= random_range(.8, 1);
									gravity = -.1;
								}
							   instance_destroy(_list[| i], false);
					   
							   sound_play_pitch(sndDieThrow, random_range(3, 4));
							}
					    }
						mark_level_changed()
					}
					ds_list_destroy(_list);

					with parBoardObject if place_meeting(x, y, other) {
						instance_destroy(self, false);
						mark_level_changed()
					}
						
					instance_destroy();
				}
				with(collision_point(mx,my,par_bricklike,0,1)){
					if obj_layer == obj_board.obj_layer instance_destroy(self, false);
					mark_level_changed()
				}
			}
		}
	}
	
	if mode = editorMode.paint {
		if point_in_bbox(mouse_x, mouse_y, self) && (button_check(inputs.shoot) || button_check(inputs.mouse_right)) {
			var n = instance_nearest(mouse_x, mouse_y, parBoardObject);
			if instance_exists(n) {
				if variable_instance_defget(n, "colorable", false) {
					var col = button_check(inputs.shoot) ? paintcolor : -1;
					if n.color != col {
						n.set_color(col)
						mark_level_changed()
					}
				}
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