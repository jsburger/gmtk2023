function board_can_fit(object, _x, _y, halign = ALIGNMENT.CENTER, valign = ALIGNMENT.CENTER) {
	var sprite = object_get_mask(object);
	if sprite == -1 sprite = object_get_sprite(object)
	var pos = board_placement_position(object, _x, _y, halign, valign);
	
	var sprite_x = sprite_get_xoffset(sprite),
		sprite_y = sprite_get_yoffset(sprite);
	
	var box_left   = pos.x - (sprite_x - sprite_get_bbox_left(sprite)),
		box_top    = pos.y - (sprite_y - sprite_get_bbox_top(sprite)),
		box_right  = pos.x + (sprite_get_bbox_right(sprite) - sprite_x),
		box_bottom = pos.y + (sprite_get_bbox_bottom(sprite) - sprite_y);
	
	//draw_rectangle_color(
	//	box_left, box_top, box_right, box_bottom,
	//	0, 0, 0, 0, false
	//)
	
	if instance_exists(collision_rectangle(
		box_left, box_top, box_right, box_bottom,
		parBoardObject, true, false
	)) {
		var list = ds_list_create(),
			count = collision_rectangle_list(box_left, box_top, box_right, box_bottom, parBoardObject, true, false, list, false),
			found = false;
		for (var i = 0; i < count; i++) {
			if true {
				found = true;
				break
			}
		}
		ds_list_destroy(list)
		
		if found {
			return false
		}
	}
	return true
}

function board_place(object, _x, _y) {
	var pos = board_placement_position(object, _x, _y);
	return instance_create_layer(pos.x, pos.y, "Instances", object);
}

//function board_placement_position(object, _x, _y) {
//	var pos = board_grid_position(_x, _y),
//		sprite = object_get_mask(object);
//	if sprite == -1 sprite = object_get_sprite(object)
	
//	return {
//		x: pos.x + sprite_get_xoffset(sprite),
//		y: pos.y + sprite_get_yoffset(sprite)
//	}
//}

function board_grid_position(_x, _y) {
	var board_off_x = 0,
		board_off_y = 0;
	with Board {
		board_off_x = ceil((bbox_left + bbox_right)/2) mod TILE_MIN;
		board_off_y = bbox_bottom mod TILE_MIN;
	}
	
	var grid_x = snap_to_lowest(_x, TILE_MIN) + board_off_x,
		grid_y = snap_to_lowest(_y, TILE_MIN) + board_off_y;
		
	return {
		x: grid_x,
		y: grid_y
	}
}