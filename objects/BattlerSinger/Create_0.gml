/// @description 

// Inherit the parent event
event_inherited();
set_hp(50)

movemode = moveOrder.LINEAR
spr_icon = sprSingerIcon

with add_action("Scream") {
	var damage = new DamageProvider(1, other, TARGETS.PLAYER)
	accept_provider(damage)
	set_intent(INTENT.ATTACK, damage)
	hit(damage)
	buff_strength(5)

	desc = "Deal 1 Damage.\nGain 5 Strength."
}
