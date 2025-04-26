/// @description 

// Inherit the parent event
event_inherited();
set_hp(75)

movemode = moveOrder.LINEAR
spr_icon = sprCultistIcon
//size = ENEMY_SIZE.SMALL;

add_action("Slice", function() {
	MOVESTART
	hit(10)
	//freeze(4);
	MOVEEND
})

add_action("Incantation", function() {
	MOVESTART
	curse(12);
	block(6);
	//freeze(4);
	MOVEEND
})