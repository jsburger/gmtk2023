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

explosion_size = 7

get_rectangle = function() {
	var n = TILE_WIDTH * explosion_size/2
	if is_vertical return {
		x1: bbox_left - 6,
		y1: y - n,
		x2: bbox_right + 6,
		y2: y + n
	}
	return {
		x1: x - n,
		y1: bbox_top - 6,
		x2: x + n,
		y2: bbox_bottom + 6,
	}
}