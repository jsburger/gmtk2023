/// @description 

// Inherit the parent event
event_inherited();
set_hp(40)

movemode = moveOrder.RANDOM_STACK

with add_action("Attack") {
	var damage = 10;
	set_intent(INTENT.ATTACK, damage)
	hit(damage)

	desc = "Deal 10 Damage."
}

with add_action("Drain") {
	set_intent(INTENT.DEBUFF)
	recolor(6, MANA_NONE)
	desc = "Uncolor 6 Bricks"
}
