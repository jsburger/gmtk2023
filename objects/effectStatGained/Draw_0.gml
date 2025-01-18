/// @description 
var alpha = 1 - progress/progress_max,
	old_alpha = image_alpha;
draw_set_alpha(alpha)
image_alpha *= alpha;
draw_self();
image_alpha = old_alpha;
if (value > 1 || value <= -1) {
	var draw_value = value;
	if (value > 0) {
		draw_value = "+" + string(value);
	}
	font_push(fntSmall, fa_right);
	draw_set_color(c_white) //fntSmall sets the color to black by default...
	draw_text_transformed(x, y, draw_value, 1, 1, image_angle)
	font_pop();
}
draw_set_alpha(1)
