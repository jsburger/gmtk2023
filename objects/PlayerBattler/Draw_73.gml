/// @description Draw Health Bar

	var hp = floor(display_health.get()),
		block = floor(block_display.get());
	var _y = bbox_bottom + 16,
		_x = x + 48;
	draw_health_bar(_x, _y + 12, hp, hp_max, 2)
	var scale = .75;
	draw_number_panel_centered(_x, _y, string(hp), c_white, hpsize, scale)
	if block > 0 {
		draw_number_panel(bbox_left + 4, _y, string(block), merge_color(c_blue, c_white, .5), undefined, scale, c_white)
	}

	// Draw statuses
	statuses.draw_player(bbox_right + 32, bbox_top)