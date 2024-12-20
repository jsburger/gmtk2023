/// @description 

// Inherit the parent event
event_inherited();
set_hp(75)

movemode = moveOrder.LINEAR
spr_icon = sprCultistIcon
//size = ENEMY_SIZE.SMALL;

with add_action("Slice") {	
	set_intent(INTENT.ATTACK, 10)
	hit(10)
	
	//freeze(4);

	desc = "Deal 10 Damage."
}

with add_action("Incantation") {	
	set_intent(INTENT.DEBUFF, 12)
	curse(12);
	
	block(6);
	//freeze(4);

	desc = "Curse 12 Bricks.\nAdd 6 Block."
}