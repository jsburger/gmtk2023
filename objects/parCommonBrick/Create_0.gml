/// @description Colored, status prone bricks

// Inherit the parent event
event_inherited();

mana_amount = 1;
colorable = true;
image_blend = #919a9f;

// Chance to become yellow
if color == -1 && !Board.editor && chance(1, 10) {
	set_color(MANA.YELLOW);
}

flip;
shuffle;