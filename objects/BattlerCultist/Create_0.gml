/// @description 

// Inherit the parent event
event_inherited();
set_hp(75)

movemode = moveOrder.LINEAR
spr_icon = sprCultistIcon
//size = ENEMY_SIZE.SMALL;

with add_action("Incantation") {	
	set_intent(INTENT.DEBUFF, 16)
	curse(16);
	
	//freeze(4);

	desc = "Curse 16 Bricks."
}

with add_action("Slice") {	
	set_intent(INTENT.ATTACK, 12)
	hit(12)
	
	//freeze(4);

	desc = "Deal 12 Damage."
}