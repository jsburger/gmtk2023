/// @description Insert description here
// You can write your code in this editor


var xoff = 0,
	draw_x = x,
	delta_x = draw_x + 36,
	gap = 100;

for(var i = MANA.RED; i < MANA.MAX; i++) {
	var color = merge_color(mana_get_color(i), c_white, blink[i]/3)
	draw_number_panel(delta_x + gap * i, y - 34, string(global.mana_gained[i]), color, 2, .5);
	var number = global.mana[i];
	if Board.editor {
		number = bricks_with_color(i);
	}
	draw_number_panel(draw_x + gap * i, y, string(number), color, 2);
}
if Board.editor {
	draw_number_panel(draw_x + gap * i - 12, y, string(bricks_with_color(COLORS.NONE)), c_gray, 2, .5)
}

//draw_text(x, y, global.mana[MANA.RED]);
//draw_text(x, y + 16, global.mana[MANA.BLUE]);
//draw_text(x, y + 32, global.mana[MANA.YELLOW]);

//draw_text(x + 32, y, global.mana_gained[MANA.RED]);
//draw_text(x + 32, y + 16, global.mana_gained[MANA.BLUE]);
//draw_text(x + 32, y + 32, global.mana_gained[MANA.YELLOW]);