/// @description Colored, status prone bricks

// Inherit the parent event
event_inherited();

mana_amount = 1;
colorable = true;
image_blend = #919a9f;
color_value = random_range(.9, 1.15);
modify_tint = function() {
	var color = make_color_hsv(
		color_get_hue(image_blend),
		color_get_saturation(image_blend),
		color_get_value(image_blend) * color_value
	);
	image_blend = color;
}
modify_tint();

can_curse = true;


can_become_yellow = true;
// Chance to become yellow
on_level_placement.add_layer(function() {
	if can_become_yellow && color == MANA_NONE && chance_good(1, 10) {
		set_color(MANA.YELLOW);
	}
})

flip;
shuffle;