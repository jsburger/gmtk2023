/// @description Draw Health Bar

	var hp = floor(display_health.get());
	var _y = bbox_bottom + 4;
	draw_health_bar(x, _y + 12, hp, hpmax)
	draw_number_panel_centered(x, _y, string(hp), c_white, hpsize, .5)
	draw_number_panel(bbox_left - 12, _y, string(block), merge_color(c_blue, c_white, .5), undefined, .5)


	// Draw statuses
	statuses.draw(bbox_left, bbox_bottom + 64)