/// @description 

// Inherit the parent event
event_inherited();
set_hp(50)

movemode = moveOrder.RANDOM_STACK
spr_icon = sprSmokerIcon

add_action("Burn Attack", function() {
	MOVESTART
	hit(9);
	burn(6);
	MOVEEND
});

add_action("Burn Shield", function() {
	MOVESTART
	block(6);
	burn(12);
	MOVEEND
});

