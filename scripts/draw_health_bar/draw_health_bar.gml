function draw_health_bar(x, y, value, value_max, scale = 1, color = c_red) {
	var magic = sprite_get_width(sprHealthBarOver)/2 * scale;
	draw_sprite_ext(sprHealthBarUnder, 0, x - magic, y, value/value_max * scale, scale, 0, color, 1);
	draw_sprite_ext(sprHealthBarOver, 0, x - magic, y, scale, scale, 0, c_white, 1);
}