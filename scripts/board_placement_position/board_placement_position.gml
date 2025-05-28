enum ALIGNMENT {
	LOWER, //Left, Top
	CENTER,
	UPPER //Right, Bottom
}

function board_placement_position(object, _x, _y, halign = ALIGNMENT.CENTER, valign = ALIGNMENT.CENTER) {
	var pos = board_grid_position(_x, _y),
		mask = object_get_real_mask(object);
	
	var right  = sprite_get_bbox_right( mask) + 1,
		left   = sprite_get_bbox_left(  mask),
		top    = sprite_get_bbox_top(   mask),
		bottom = sprite_get_bbox_bottom(mask) + 1,
		xoff = sprite_get_xoffset(mask),
		yoff = sprite_get_yoffset(mask),
		xgap = xoff - left,
		ygap = yoff - top;
	
	
	switch halign {
		case ALIGNMENT.LOWER:
			pos.x = pos.x + (xgap);
			break;
		case ALIGNMENT.CENTER:
			pos.x += mod_nearest_offset(round((left + right)/2), TILE_MIN)
			break;
		case ALIGNMENT.UPPER:
			pos.x = pos.x - (right - xoff);
			break;
	}
	switch valign {
		case ALIGNMENT.LOWER:
			pos.y = pos.y + (ygap);
			break;
		case ALIGNMENT.CENTER:
			pos.y += mod_nearest_offset(round((top + bottom)/2), TILE_MIN);
			break;
		case ALIGNMENT.UPPER:
			pos.y = pos.y - (bottom - yoff);
			break;
	}
	
	
	return {
		x : clamp(pos.x, board_left + TILE_MIN + (xgap), board_right - TILE_MIN - (right - xoff)),
		y : clamp(pos.y, board_top + TILE_MIN + (ygap), board_bottom - TILE_MIN - (bottom - yoff))
	}
}

/// Returns the "smallest" offset using modulo. Purpose built for grid alignment.
function mod_nearest_offset(n, modulo) {
	var m = n mod modulo,
		negative = modulo - m;
	if abs(negative) < m {
		return -negative;
	}
	return m;
}