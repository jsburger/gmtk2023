/// @description 

// Inherit the parent event
event_inherited();
set_hp(60)

movemode = moveOrder.LINEAR
spr_icon = sprSuperGermIcon
//size = ENEMY_SIZE.SMALL;


with add_action("Super Yuck") {
	set_intent(INTENT.DEBUFF, 12)
	poison(12)
	
	desc = "Apply 12 Poison."
}

with add_action("Regenerate") {
	set_intent(INTENT.BLOCK, 12)
	
	block(12);
	
	desc = "Add 12 Shield."
}
