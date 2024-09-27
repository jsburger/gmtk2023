/// @description 

var offset = -80 * animcurve_channel_evaluate(curve, progress/progress_max);

if progress <= 6 {
	draw_set_color(c_black)
}
var blink = (progress > (1 sec)) && progress mod 10 < 2;

font_push(fntBig, fa_center)
if !blink draw_text_transformed(x, y + offset, damage, 2, 2, tilt);
font_pop()

if progress <= 6 {
	draw_set_color(c_white)
}