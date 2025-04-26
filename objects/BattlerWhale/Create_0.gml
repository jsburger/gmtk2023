/// @description 

// Inherit the parent event
event_inherited();
set_hp(120)

movemode = moveOrder.RANDOM
move_max = 3;
spr_icon = sprWhaleIcon

add_action("All In!!", function() {
	MOVESTART
	var damage = as_damage(new FunctionProvider(mana_get_sum));
	hit(damage)
	add_intent(new Intent(sprIntentAttack, damage))
		.with_desc("Deal Damage equal\nto total Mana.");
	MOVEEND
})

add_action("Raise", function() {
	MOVESTART
	freeze(4);
	MOVEEND
})
