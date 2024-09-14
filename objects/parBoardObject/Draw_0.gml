/// @description draw_self();

draw_self();

if is_frozen draw_sprite(spr_frozen, spr_frozen_index, x, y)
if is_poisoned draw_sprite_ext(spr_poison, spr_poison_index, x, y, image_xscale, 1, 0, mana_get_color(color), 1)