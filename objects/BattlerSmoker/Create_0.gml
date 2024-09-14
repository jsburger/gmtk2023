/// @description 

// Inherit the parent event
event_inherited();
set_hp(50)

movemode = moveOrder.RANDOM_STACK
spr_icon = sprSmokerIcon

with add_action("Burn Attack") {
	set_intent(INTENT.ATTACK, 9)
	
	hit(9);
	burn(6);
	desc = "Deal 9 Damage.\nBurn 6 Bricks."
}

with add_action("Burn Shield") {
	set_intent(INTENT.BLOCK, 6)
	
	block(6);
	burn(12);
	desc = "Add 6 Shield.\nBurn 12 Bricks."
}

