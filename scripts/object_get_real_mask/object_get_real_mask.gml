function object_get_real_mask(object) {
	var mask = object_get_mask(object);
	if mask == -1 return object_get_sprite(object);
	return mask;
}

function object_width(object) {
	var mask = object_get_real_mask(object);
	return (sprite_get_bbox_right(mask) + 1) - sprite_get_bbox_left(mask);
}

function object_height(object) {
	var mask = object_get_real_mask(object);
	return (sprite_get_bbox_bottom(mask) + 1) - sprite_get_bbox_top(mask);
}