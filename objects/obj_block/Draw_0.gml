/// @description Draw frozen overlay

// Inherit the parent event
event_inherited();

if frozen {
	draw_sprite_ext(spr_frozen, spr_frozen_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha)
}