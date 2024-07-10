/// @description 

// Inherit the parent event
event_inherited();
set_hp(30)

movemode = moveOrder.LINEAR

with add_action("fart") {
	//var damage = range(4, 6);
	var range = new RangeProvider(4, 8);
	var damage = new DamageProvider(range, other, TARGETS.PLAYER);
	accept_provider(damage)
	set_intent(INTENT.ATTACK, damage)
	hit(damage)
	block(4)
	desc = new Formatter("Deal {0} Damage", range);
}

with add_action("pee") {
	var damage = new DamageProvider(12, other, TARGETS.PLAYER)
	accept_provider(damage)
	set_intent(INTENT.ATTACK, damage)
	hit(damage)
	desc = "Deal 12 Damage"
}
