function draw_health_bar(x, y, value, value_max, color = c_red) {
	var magic = sprite_get_width(sprHealthBarOver)/2;
	draw_sprite_ext(sprHealthBarUnder, 0, x - magic, y, value/value_max, 1, 0, color, 1);
	draw_sprite(sprHealthBarOver, 0, x - magic, y);
}