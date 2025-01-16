/// @description 

// Inherit the parent event
event_inherited();
set_hp(120)

movemode = moveOrder.RANDOM
move_max = 3;
spr_icon = sprWhaleIcon

with add_action("All In!!") {
	var damage = as_damage(new FunctionProvider(mana_get_sum));
	hit(damage)
	add_intent(new Intent(sprIntentAttack, damage))
		.with_desc("Deal Damage equal\nto total Mana.");

}

with add_action("Raise") {
	freeze(4);
}
