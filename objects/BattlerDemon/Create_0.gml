/// @description 

// Inherit the parent event
event_inherited();

// Add context sensitive editor objects
extra_objects = [DemonOrb]

set_hp(99);

on_die = function() {
	spell_grant(SPELLS.PLACE_ORB);
}

purple_counter = 0;

on_mana_gained = function(color, count) {
	if color == COLORS.PURPLE {
		purple_counter += count;
	}
}

add_action("Demon Smash", function() {
	var get_purple = function() {
		return purple_counter
	}
	
	MOVESTART
	var damage = as_damage(new FunctionProvider(get_purple));
	hit(damage)
	add_intent(new Intent(sprDemonAttackIndicator, damage)
		.with_desc(format("Deals damage equal to\nthe amount of PURPLE mana\ngained this battle.")))
		
	MOVEEND 
})