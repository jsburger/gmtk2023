/// @description 

draw_self();
if on && hp < hp_max {
	var blend = 1 - (hp/hp_max);
	draw_sprite_ext(spr_off, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha * blend);
}

if is_frozen draw_sprite(spr_frozen, spr_frozen_index, x, y)