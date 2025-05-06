function EditorPlacer() constructor {
	
	/// Called when the swap buttons are pressed
	static cycle = function(dir) {}
	
	/// Observes the object, returns if the object can be created with this placer.
	/// Also changes state to match it.
	static try_match = function(object) { return false; }
	
	/// Draw a preview for the object.
	static draw_preview = function(_x, _y) {}
	
	/// Draw a phantom or whatever the object needs.
	/// Drawn in world space.
	static draw_world = function() {}
	
	static draw_variants = function(_x, _y, gap) {}

	/// Run when the mouse clicks
	static on_click = function() {}
	static on_hold = function(last_x, last_y) {}
	static on_release = function() {}
	
	static on_right_click = function() {};
	static on_right_click_hold = function(last_x, last_y) {};
	static on_right_click_release = function() {};
	
	/// Called when the placer is swapped off
	static reset = function() {}
	
}

/// Class dedicated to making collision based placers easier
function AbstractObjectPlacer() : EditorPlacer() constructor {
	
	last_placement_x = 0;
	last_placement_y = 0;
	has_placed = false;
	line_enabled = true;
	base_draw = draw;
	
	#region Internal
	static get_object = function() { return BrickNormal };
	
	static object_position = function(_x = mouse_x, _y = mouse_y) {
		var obj = get_object(),
			mask = object_get_real_mask(obj);
		
		var valign = ALIGNMENT.CENTER;
		if keyboard_check(ord("W")) valign = ALIGNMENT.LOWER;
		if keyboard_check(ord("S")) valign = ALIGNMENT.UPPER;
		var halign = ALIGNMENT.CENTER;
		if keyboard_check(ord("A")) halign = ALIGNMENT.LOWER;
		if keyboard_check(ord("D")) halign = ALIGNMENT.UPPER;

		return board_placement_position(obj, _x, _y, halign, valign);
		
		//var pos = board_grid_position(_x, _y),
		//	right = sprite_get_bbox_right(  mask) + 1,
		//	left  = sprite_get_bbox_left(   mask),
		//	top   = sprite_get_bbox_top(    mask),
		//	bottom = sprite_get_bbox_bottom(mask) + 1,
		//	xoff = sprite_get_xoffset(mask),
		//	yoff = sprite_get_yoffset(mask);
		//return {
		//	x : clamp(pos.x + (xoff mod TILE_MIN), board_left + TILE_MIN + (xoff - left), board_right - TILE_MIN - (right - xoff)),
		//	y : clamp(pos.y + (yoff mod TILE_MIN), board_top + TILE_MIN + (yoff - top), board_bottom - TILE_MIN - (bottom - yoff))
		//}
		
	}
	
	static get_rotation = function() { return 0; }
	
	static can_place = function(_x = mouse_x, _y = mouse_y) {
		var pos = object_position(_x, _y);
		return !mask_meeting(pos.x, pos.y, object_get_real_mask(get_object()), [parBoardObject, CollisionFrameOccupier], get_rotation())
	}
	
	static try_place = function(_x, _y) {
		if can_place(_x, _y) {
			var pos = object_position(_x, _y);
			
			sound_play_pitch(sndDieHitBrick, random_range(1.7, 3));
			
			with instance_create_layer(pos.x, pos.y, "Instances", get_object()) {
				placement_effect(self)
				other.modify_object(self);
			}
			
			has_placed = true;
			last_placement_x = _x;
			last_placement_y = _y;
			
			mark_level_changed()
		}
	}
	
	static try_delete = function(_x, _y) {
		var pos = object_position(_x, _y),
			list = mask_meeting_list(pos.x, pos.y, object_get_real_mask(get_object()), parBoardObject),
			size = ds_list_size(list);
		
		for (var i = 0; i < size; i++) {
			sound_play_pitch(sndDieThrow, random_range(3, 4));
			placement_effect(list[| i])
			
			instance_destroy(list[| i], false)
		}
		if size > 0 mark_level_changed()
		ds_list_destroy(list)
	}
	
	static draw = function(_x, _y, canplace) {
		var sprite = object_get_sprite(get_object())
		draw_sprite_ext(sprite, sprite_get_animation_frame(sprite), _x, _y, 1, 1, get_rotation(), canplace ? c_green : c_red, .8);
	}
	
	
	static reset_placement = function() {
		last_placement_x = 0;
		last_placement_y = 0;
		has_placed = false;
	}
	
	static modify_object = function(object) {}
	#endregion
	
	#region External
	static reset = function() {
		reset_placement();
	}
	
	static draw_preview = function(_x, _y) {
		var sprite = object_get_sprite(get_object());
		draw_sprite_auto(sprite, _x, _y)
	}
	
	static draw_world = function() {
		if line_enabled && has_placed && button_check(inputs.editor_modifier) {
			run_across_line(last_placement_x, last_placement_y, mouse_x, mouse_y, TILE_MIN, function(_x, _y) {
				var pos = object_position(_x, _y);
				if !mask_meeting(pos.x, pos.y, object_get_real_mask(get_object()), CollisionFrameOccupier, get_rotation()){
					draw(pos.x, pos.y, can_place(_x, _y))
					with instance_create_layer(pos.x, pos.y, "Instances", CollisionFrameOccupier) {
						mask_index = object_get_real_mask(other.get_object())
					}
				}
			})
			with CollisionFrameOccupier instance_destroy(self)
		}
		
		else {
			var pos = object_position();
			draw(pos.x, pos.y, can_place())
		}
	}
	
	
	static on_click = function() {
		if line_enabled && has_placed && button_check(inputs.editor_modifier) {
			run_across_line(last_placement_x, last_placement_y, mouse_x, mouse_y, TILE_MIN, try_place)
		}
		else {
			try_place(mouse_x, mouse_y)
		}
	}
	
	static on_hold = function(last_x, last_y) {
		run_across_line(last_x, last_y, mouse_x, mouse_y, 16, try_place)
	}
	
	static on_right_click = function() {
		try_delete(mouse_x, mouse_y)
	}
	
	static on_right_click_hold = function(last_x, last_y) {
		run_across_line(last_x, last_y, mouse_x, mouse_y, 16, try_delete)
	}
	
	#endregion
}

function ObjectPlacer() : AbstractObjectPlacer() constructor {
	objects = [];
	if is_array(argument[0]) objects = argument[0]
	else {
		for (var i = 0; i < argument_count; i++) {
			array_push(objects, argument[i])
		}
	}
	
	selected = 0;
	
	static get_object = function() {
		return objects[selected]
	}
	
	static cycle = function(dir) {
		selected += dir;
		if selected >= array_length(objects) selected = 0;
		if selected < 0 selected = array_length(objects) - 1;
		
	}
	
	static reset = function() {
		reset_placement()
		//selected = 0;
	}
	
	static try_match = function(object) {
		var index = array_find(objects, object.object_index);
		if index != undefined {
			selected = index;
			return true;
		}
		return false;
	}
	
	static draw_variants = function(_x, _y, gap) {
		for (var i = 0; i < array_length(objects); i++) {
			var sprite = object_get_sprite(objects[i]);
			draw_sprite_ext(sprite, sprite_get_animation_frame(sprite), _x + gap * (i - selected), _y, 1, 1, 0, c_white, .6);
		}
	}
}

function SingleObjectPlacer(obj) : AbstractObjectPlacer() constructor {
	object = obj;
	static try_match = function(object) {
		return matches(object);
	}
	static get_object = function() {
		return object
	}
	static matches = function(object) {
		return self.object == object.object_index;
	}
}

function PortalPlacer() : SingleObjectPlacer(Portal) constructor {
	index = 0;
	spr_back = sprPortalBackPurple;
	line_enabled = false;
	
	static cycle = function(dir) {
		index += dir;
		if index < 0 index = 5;
		if index > 5 index = 0;
		spr_back = portal_get_sprites(index).spr_back;
	}
	
	static draw = function(_x, _y, canplace) {
		var sprite = sprPortalLipsIdle
		draw_sprite_ext(spr_back, sprite_get_animation_frame(spr_back), _x, _y, 1, 1, get_rotation(), canplace ? c_green : c_red, .8)
		draw_sprite_ext(sprite, sprite_get_animation_frame(sprite), _x, _y, 1, 1, get_rotation(), canplace ? c_green : c_red, .8)
	}
	
	static draw_preview = function(_x, _y) {
		draw_sprite_auto(spr_back, _x, _y)
		draw_sprite_auto(sprPortalLipsIdle, _x, _y)
	}
	
	static modify_object = function(object) {
		object.set_index(index)
	}
	
	static try_match = function(object) {
		if matches(object) {
			index = object.index;
			return true;
		}
		return false;
	}
}

function LauncherPlacer(object) : SingleObjectPlacer(object) constructor {
	rotation = 90;
	line_enabled = false;
	nograv = object != Barrel;
	
	static cycle = function(dir) {
		var turning = button_check(inputs.editor_modifier) ? 5 : 45;
		rotation -= turning * dir;
		rotation = anglefy(rotation);
	}
	
	static get_rotation = function() {
		return rotation - 90;
	}
	
	static modify_object = function(object) {
		object.set_launch_direction(rotation)
	}
	
	static draw = function(_x, _y, canplace) {
		base_draw(_x, _y, canplace);
		draw_dice_preview(_x, _y, rotation, 14, {nograv})
	}
	
	static reset = function() {
		reset_placement()
		rotation = 90;
	}
	
	static try_match = function(object) {
		if matches(object) {
			rotation = object.launch_direction;
			return true;
		}
		return false;
	}
}

function RotatingPlacer(obj, rotation_amount) : SingleObjectPlacer(obj) constructor {
	rotation = 0;
	self.rotation_amount = rotation_amount;
	
	static cycle = function(dir) {
		var turning = button_check(inputs.editor_modifier) ? 5 : rotation_amount;
		rotation += turning * -dir;
		rotation = anglefy(rotation);
	}
	
	static get_rotation = function() {
		return rotation;
	}
	
	static modify_object = function(object) {
		object.set_rotation(rotation)
	}
	
	static reset = function() {
		reset_placement()
		rotation = 0;
	}
	
	static try_match = function(object) {
		if matches(object) {
			rotation = object.image_angle;
			return true;
		}
		return false;
	}
}

