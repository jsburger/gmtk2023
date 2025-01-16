/// @description 

// Inherit the parent event
event_inherited();
set_hp(50)

movemode = moveOrder.RANDOM_STACK
spr_icon = sprSmokerIcon

with add_action("Burn Attack") {
	hit(9);
	burn(6);
}

with add_action("Burn Shield") {
	block(6);
	burn(12);
}

