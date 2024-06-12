/// @description 

// Inherit the parent event
event_inherited();

movemode = moveOrder.LINEAR

with add_action("fart") {
	//var damage = range(4, 6);
	
	var damage = new DamageProvider(new RangeProvider(4, 6), other, TARGETS.PLAYER);
	accept_provider(damage)
	set_intent(INTENT.ATTACK, damage)
	hit(damage)
}

with add_action("pee") {
	var damage = as_damage(new RangeProvider(8, 12));
	set_intent(INTENT.ATTACK, damage)
	hit(damage)
}
