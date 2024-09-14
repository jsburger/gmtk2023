function draw_textbox(_x, _y, _lines) {
	static dump = [1];
	if !is_array(_lines) {
		dump[0] = _lines
		_lines = dump
	}
	var width = 0,
		height = 0,
		sep = 8;
	for (var i = 0; i < array_length(_lines); i++) {
		width = max(string_width(_lines[i]), width)
		height += string_height(_lines[i]);
		if i > 0 height += sep
	}
	if _x + width > cam_right {
		_x -= (_x + width) - cam_right
	}
	
	var padding = 2;
	draw_rectangle_simple(_x, _y, _x + width + 2 * padding, _y + height + 2 * padding, c_black, .6);
	var draw_x = _x + padding,
		draw_y = _y + padding;
	for (var i = 0; i < array_length(_lines); i++) {
		draw_text(draw_x, draw_y, _lines[i])
		draw_y += sep + string_height(_lines[i])
	}
	
	return height + 2 * padding;
}

function draw_rectangle_simple(x1, y1, x2, y2, color, alpha = 1) {
	draw_set_alpha(alpha)
	draw_rectangle_color(x1, y1, x2, y2, color, color, color, color, false)
	draw_set_alpha(1)
}