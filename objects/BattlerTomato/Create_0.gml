/// @description 

// Inherit the parent event
event_inherited();
set_hp(50)

movemode = moveOrder.LINEAR
spr_icon = sprTomatoIcon

with add_action("Bite") {
	var range = new RangeProvider(6, 12);
	var damage = new DamageProvider(range, other, TARGETS.PLAYER);
	accept_provider(damage)
	set_intent(INTENT.ATTACK, damage)
	hit(damage)
	recolor(12, MANA.RED)

	desc = new Formatter("Deal {0} Damage.\nRecolor 12 Bricks Red.", range);
}

with add_action("Splat") {
	set_intent(INTENT.BLOCK, 10)
	block(10)
	recolor(12, MANA.RED)
	desc = "Add 10 Shield.\nRecolor 12 Bricks Red."
}


//with add_action("Explode") {
//	var damage = new DamageProvider(30, other, TARGETS.PLAYER);
//	accept_provider(damage)
//	set_intent(INTENT.ATTACK, damage)
//	hit(damage)
	
//	recolor(18, MANA.RED)	
	
//	attack(TARGETS.SELF, damage);

//	desc = "Deal 30 Damage to\nplayer and self.\nRecolor 18 Bricks Red."
//}