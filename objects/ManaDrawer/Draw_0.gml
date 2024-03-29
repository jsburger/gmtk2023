/// @description Insert description here
// You can write your code in this editor



draw_number_panel(x + 36, y - 34, string(global.mana_gained[MANA.RED]), c_red, 2, .5)
draw_number_panel(x, y, string(global.mana[MANA.RED]), c_red, 2)

draw_number_panel(x + 36 + 128, y - 34, string(global.mana_gained[MANA.BLUE]), c_blue, 2, .5)
draw_number_panel(x + 128, y, string(global.mana[MANA.BLUE]), c_blue, 2)

draw_number_panel(x + 36 + 256, y - 34, string(global.mana_gained[MANA.YELLOW]), c_yellow, 2, .5)
draw_number_panel(x + 256, y, string(global.mana[MANA.YELLOW]), c_yellow, 2)

//draw_text(x, y, global.mana[MANA.RED]);
//draw_text(x, y + 16, global.mana[MANA.BLUE]);
//draw_text(x, y + 32, global.mana[MANA.YELLOW]);

//draw_text(x + 32, y, global.mana_gained[MANA.RED]);
//draw_text(x + 32, y + 16, global.mana_gained[MANA.BLUE]);
//draw_text(x + 32, y + 32, global.mana_gained[MANA.YELLOW]);