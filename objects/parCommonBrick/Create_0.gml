/// @description Colored, status prone bricks

// Inherit the parent event
event_inherited();

mana_amount = 1;
colorable = true;


// Chance to become yellow
if color == -1 && !obj_board.editor && chance(1, 10) {
	set_color(MANA.YELLOW);
}

flip;
shuffle;