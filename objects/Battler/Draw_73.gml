/// @description Draw Health Bar

	var hp = floor(display_health.get()),
		block = floor(block_display.get());
	var _y = bbox_bottom + 4;
	draw_health_bar(x, _y + 12, hp, hp_max)
	var scale = instance_is(self, PlayerBattler) ? .75 : .5;
	draw_number_panel_centered(x, _y, string(hp), c_white, hpsize, scale)
	draw_number_panel_centered(bbox_left - 12, _y, string(block), merge_color(c_blue, c_white, .5), undefined, scale)


	// Draw statuses
	statuses.draw(bbox_left, bbox_bottom + 32)