/// @description draw_self();

if is_cursed { //This gets replaced later
	var alpha = .4 + dsin((current_frame * 3) + manhatten_distance(x, y, board_left, board_top)) * .1,
		scale = 1.3;
	draw_sprite_ext(
		sprite_index, image_index, x, y,
		image_xscale * scale, image_yscale * scale,
		image_angle, c_fuchsia, alpha
	)
}

draw_self();

if is_frozen draw_sprite(spr_frozen, spr_frozen_index, x, y)
if is_poisoned draw_sprite_ext(spr_poison, spr_poison_index, x, y, image_xscale, 1, 0, mana_get_color(color), 1)
if is_cursed draw_sprite(sprCurseOverlay, 0, x, y)