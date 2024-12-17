global.metal_points = [{radius: 1, x: 0, y: 0, hue: 0, value: 0}]


function metal_brick_tint(_x, _y) {
	var base = c_ltgray;
	var hue = color_get_hue(base),
		sat = color_get_saturation(base),
		val = color_get_value(base),
		red = color_get_red(base),
		green = color_get_green(base),
		blue = color_get_blue(base);
	for (var i = 0; i < array_length(global.metal_points); i++) {
		var point = global.metal_points[i],
			factor = max(0, point.radius - point_distance(_x, _y, point.x, point.y))/point.radius;
		hue += factor * point.hue;
		val += factor * point.value;
		sat += factor * abs(point.hue) * 2;
		blue += factor * point.blue;
		red += factor * point.red;
		green += factor * min(point.red, point.blue);
	}
	return make_color_rgb(red, green, blue);
	return make_color_hsv(hue, sat, val);
}

/// @ignore
function generate_brick_tints() {
	array_clear(global.metal_points);
	repeat(irandom_range(10, 20)) {
		array_push(global.metal_points, {
			x: random_range(board_left, board_right),
			y: random_range(board_top, board_bottom),
			radius: random_range(100, 400),
			hue: random_range(-40, 40),
			value: random_range(-12, 12),
			red: random_range(-25, 10),
			blue: random_range(-25, 10)
		});
	}
}