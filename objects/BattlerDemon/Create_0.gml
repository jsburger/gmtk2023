/// @description 

// Inherit the parent event
event_inherited();

// Add context sensitive editor objects
extra_objects = [DemonOrb]

set_hp(99);

purple_counter = 0;

on_mana_gained = function(color, count) {
	if color == COLORS.PURPLE {
		purple_counter += count;
	}
}

var get_purple = function() {
	return purple_counter
}

with add_action("Demon Smash") {
	var damage = as_damage(new FunctionProvider(get_purple));
	hit(damage)
	set_intent(INTENT.ATTACK, damage)
	desc = new Formatter("Deals damage equal to\nthe amount of PURPLE mana\ngained this battle.")
}