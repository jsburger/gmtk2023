/// @description 

// Inherit the parent event
event_inherited();
set_hp(30)

movemode = moveOrder.LINEAR

with add_action("fart") {
	//var damage = range(4, 6);
	
	var damage = new DamageProvider(new RangeProvider(4, 8), other, TARGETS.PLAYER);
	accept_provider(damage)
	set_intent(INTENT.ATTACK, damage)
	hit(damage)
}

with add_action("pee") {
	var damage = new DamageProvider(12, other, TARGETS.PLAYER)
	accept_provider(damage)
	set_intent(INTENT.ATTACK, damage)
	hit(damage)
}
