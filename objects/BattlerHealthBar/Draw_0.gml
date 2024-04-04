/// @description 
if instance_exists(target) {
	draw_number_panel(x + 24, y, string(target.hp), c_white, 2, 1)
	draw_number_panel(target.bbox_left, y, string(target.block), merge_color(c_blue, c_white, .5), string_length(string(target.block)))
}
else instance_destroy(self)