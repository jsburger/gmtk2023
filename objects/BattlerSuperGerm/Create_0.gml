/// @description 

// Inherit the parent event
event_inherited();
set_hp(60)

movemode = moveOrder.LINEAR
spr_icon = sprSuperGermIcon
//size = ENEMY_SIZE.SMALL;


with add_action("Super Yuck") {
	poison(12)
}

with add_action("Regenerate") {
	block(12);
}
