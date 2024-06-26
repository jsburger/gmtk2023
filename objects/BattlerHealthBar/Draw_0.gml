/// @description 
if instance_exists(target) {
	var hp = floor(display_health);
	var _y = target.bbox_bottom + 4;
	draw_health_bar(target.x, _y + 12, hp, target.hpmax)
	draw_number_panel_centered(target.x, _y, string(hp), c_white, 2, .5)
	draw_number_panel(target.bbox_left - 12, _y, string(target.block), merge_color(c_blue, c_white, .5), string_length(string(target.block)), .5)
}
else instance_destroy(self)