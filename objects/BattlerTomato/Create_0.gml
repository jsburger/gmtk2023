/// @description 

// Inherit the parent event
event_inherited();
set_hp(50)

movemode = moveOrder.LINEAR
spr_icon = sprTomatoIcon

add_action("Bite", function() {
	MOVESTART
	var range = new RangeProvider(6, 12);
	hit(as_damage(range))
	recolor(12, MANA.RED)
	add_intent(new RecolorIntent(12, MANA.RED))
	MOVEEND
})

add_action("Splat", function() {
	MOVESTART
	block(10)
	recolor(12, MANA.RED)
	add_intent(new RecolorIntent(12, MANA.RED))
	MOVEEND
})


//with add_action("Explode") {
//	var damage = new DamageProvider(30, other, TARGETS.PLAYER);
//	accept_provider(damage)
//	set_intent(INTENT.ATTACK, damage)
//	hit(damage)
	
//	recolor(18, MANA.RED)	
	
//	attack(TARGETS.SELF, damage);

//	desc = "Deal 30 Damage to\nplayer and self.\nRecolor 18 Bricks Red."
//}