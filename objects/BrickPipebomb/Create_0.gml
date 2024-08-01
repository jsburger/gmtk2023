/// @description 

// Inherit the parent event
event_inherited();
image_speed = 0;

flip;
beeped = false;
is_vertical = false;

set_hp(2)
on_hurt = function(damage) {
	image_speed = 1;
	if !beeped {
		beeped = true;
		sound_play(sndPipebombLit)
	}
}

get_rectangle = function() {
	if is_vertical return {
		x1: bbox_left - 6,
		y1: board_top,
		x2: bbox_right + 6,
		y2: board_bottom
	}
	return {
		x1: board_left,
		y1: bbox_top - 6,
		x2: board_right,
		y2: bbox_bottom + 6,
	}
}