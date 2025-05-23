if !surface_exists(marker_surface) {
	marker_surface = surface_create(cam_width, cam_height);
	surface_set_target(marker_surface);
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
}

var camera_x = cam_x,
	camera_y = cam_y;
if instance_exists(obj_screenshake) {
	camera_x = obj_screenshake.camera_x;
	camera_y = obj_screenshake.camera_y;
}
draw_surface_ext(marker_surface, camera_x, camera_y, 1, 1, 0, c_white, .6);
if button_check(inputs.draw) && !button_check(inputs.inspect) {
	if button_check(inputs.dash) {
		draw_sprite_auto(sprMarkerEraser, mouse_x, mouse_y)
	}
	else {
		var _y = mouse_y - (button_check(inputs.shoot) ? 0 : 10)
		draw_sprite_auto(sprMarkerCursor, mouse_x, _y);
		draw_sprite_ext(sprMarkerCursorOverlay, 0, mouse_x, _y, 1, 1, 0, mana_get_color(marker_color_index), 1);
	}
}


if(editor){
	
	var _str =
	@"Welcome to the Level Editor!
	Controls:
	Mouse Wheel:       Change brick                             Q & E:  Change brick version
	Left Click:        Place brick (hold to place many)         N: New  Blank Level
	Right Click:       Un-place brick (hold to un-place many)   Enter:  Save level
	Up/Down Arrows:    Move level up/down                       Delete: Clear level
	Left/Right Arrows: Cycle through levels                     T:      Reload level from file
	Home:              Close editor
	",
	_str2 = "levelnamegoeshere" + "   " + string(global.level_num + 1) + "/" + string(array_length(global.level_data)) + "saved?"
	
	var _c = c_white;
	if global.level_changed[global.level_num] {
		_str2 = string_replace(_str2, "saved?", " (Unsaved Changes!!!)")
		_c = c_yellow;		
	}else _str2 = string_replace(_str2, "saved?", "")
	
	_str2 = string_replace(_str2, "levelnamegoeshere", current_level.info.name)
	
	var draw_x = camera_get_view_x(0) - 300,
		draw_y = camera_get_view_y(0),
		draw_width = string_width(_str),
		draw_height = string_height(_str);
	
	var show = button_check(inputs.editor_info)
	if show {
		draw_rectangle_color(draw_x, draw_y, draw_x + draw_width + 12, draw_y + draw_height + string_height(_str2) + 8, c_black, c_black, c_black, c_black, false)
		draw_text(draw_x + 8, draw_y + 8, _str);
		
		draw_text_color(draw_x + 8, draw_y + draw_height + 8, _str2, _c, _c, _c, _c, 1);
	}
	else {
		draw_textbox(draw_x + 8, draw_y + 8, _str2)
	}
	
	//_c = canplace ? c_lime : c_red;
	//if(canplace){
	//	gpu_set_fog(true, _c, 0, 0);
	//	draw_sprite(current_sprite,image_index,mx - 1,my);
	//	draw_sprite(current_sprite,image_index,mx + 1,my);
	//	draw_sprite(current_sprite,image_index,mx,my - 1);
	//	draw_sprite(current_sprite,image_index,mx,my + 1);
	//	gpu_set_fog(false, _c, 0, 0);
	//}else{
	//	gpu_set_fog(true, _c, 0, 0);
	//	draw_sprite(current_sprite,image_index,mx,my);
	//	gpu_set_fog(false, _c, 0, 0);
	//}
	
	//draw_set_alpha(.7);
	//draw_sprite(current_sprite,image_index,mx,my);
	//draw_set_alpha(1);
	
	if mode == editorMode.build {
		var placer = current_placer();
		placer.draw_world()
		with obj_cuffs {
			placer.draw_preview(x, y);
		}
	}
	else if mode == editorMode.paint {
		var col = mana_get_color(paintcolor),
			alpha = 1;
		var n = instance_nearest(mouse_x, mouse_y, parBoardObject);
		if instance_exists(n) && distance_to_bbox(mouse_x, mouse_y, n) < 10 && n.colorable {
			///Erm..
		}
		else {
			col = merge_color(col, c_gray, .25)
			alpha = .5
		}
		draw_sprite_ext(sprEditorPaintRing, 0, mouse_x, mouse_y, 1, 1, 0, col, alpha);
	}
}