
function font_push(font, halign = draw_get_halign(), valign = draw_get_valign()) {
	static stack = [{ //Defaults
		font: fntBig,
		halign : fa_left,
		valign : fa_top
	}];
	array_insert(stack, 0, {
		font, halign, valign
	});
	draw_set_font(font)
	draw_set_halign(halign)
	draw_set_valign(valign)
	if font == fntSmall draw_set_color(c_black)
}

function font_pop() {
	var stack = font_push.stack;
	var last = array_shift(stack);
	draw_set_font(stack[0].font)
	draw_set_halign(stack[0].halign)
	draw_set_valign(stack[0].valign)
	if last.font == fntSmall && stack[0].font != fntSmall draw_set_color(c_white)
}