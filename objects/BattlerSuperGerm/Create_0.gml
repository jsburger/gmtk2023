/// @description 

// Inherit the parent event
event_inherited();
set_hp(60)

movemode = moveOrder.LINEAR
spr_icon = sprSuperGermIcon
//size = ENEMY_SIZE.SMALL;


add_action("Super Yuck", function() {
	MOVESTART
	poison(12)
	MOVEEND
})

add_action("Regenerate", function() {
	MOVESTART
	block(12);
	MOVEEND
})
