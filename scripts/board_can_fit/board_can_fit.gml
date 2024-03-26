function board_can_fit(object, _x, _y) {
	var sprite = object_get_mask(object);
	if sprite == -1 sprite = object_get_sprite(object)
	var grid_x = snap_to_lowest(_x, 16),
		grid_y = snap_to_lowest(_y, 16);
	var test_layer = object_is_ancestor(object, obj_cable) ? 1 : 0;
	
	var box_left   = grid_x + sprite_get_bbox_left(sprite),
		box_top    = grid_y + sprite_get_bbox_top(sprite),
		box_right  = grid_x + sprite_get_bbox_right(sprite),
		box_bottom = grid_y + sprite_get_bbox_bottom(sprite);
	
	
	if instance_exists(collision_rectangle(
		box_left, box_top, box_right, box_bottom,
		par_bricklike, true, false
	)) {
		var list = ds_list_create(),
			count = collision_rectangle_list(box_left, box_top, box_right, box_bottom, par_bricklike, true, false, list, false),
			found = false;
		for (var i = 0; i < count; i++) {
			if list[| i].obj_layer == test_layer {
				found = true;
				break
			}
		}
		ds_list_destroy(list)
		
		if found {
			//draw_rectangle_color(
			//	box_left, box_top, box_right, box_bottom,
			//	0, 0, 0, 0, false
			//)
			return false
		}
	}
	return true
}

function board_place(object, _x, _y) {
	var pos = board_placement_position(object, _x, _y);
	instance_create_layer(pos.x, pos.y, "Instances", object);
}

function board_placement_position(object, _x, _y) {
	var grid_x = snap_to_lowest(_x, 16),
		grid_y = snap_to_lowest(_y, 16);
	var sprite = object_get_mask(object);
	if sprite == -1 sprite = object_get_sprite(object)
	
	return {
		x: grid_x + sprite_get_bbox_left(sprite) - sprite_get_xoffset(sprite),
		y: grid_y + sprite_get_bbox_top(sprite - sprite_get_yoffset(sprite))
	}
}