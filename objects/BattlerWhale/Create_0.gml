/// @description 

// Inherit the parent event
event_inherited();
set_hp(120)

movemode = moveOrder.RANDOM
move_max = 3;

with add_action("All In!!") {
	var damage = as_damage(new FunctionProvider(mana_get_sum));
	set_intent(INTENT.ATTACK, damage)
	hit(damage)

	desc = "Deal Damage equal\nto total Mana."
}

with add_action("Raise") {
	set_intent(INTENT.DEBUFF)
	freeze(6);
	desc = "Apply 6 Freeze"
}
