/// @description 

// Inherit the parent event
event_inherited();
set_hp(50)

movemode = moveOrder.RANDOM
spr_icon = sprSmokerIcon


with add_action("Burn") {
	set_intent(INTENT.ATTACK, 4)
	
	hit(4);
	burn(8);
	desc = "Deal 4 Damage.\nBurn 8 Bricks."
}
