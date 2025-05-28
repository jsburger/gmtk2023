function draw_object_ghost(object, _x, _y, color, rotation = 0) {
	var sprite = object_get_sprite(object),
		pos = board_placement_position(object, _x, _y);
	draw_sprite_ext(sprite, sprite_get_animation_frame(sprite), pos.x, pos.y, 1, 1, rotation, color, .5)
}