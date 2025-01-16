/// @description 

// Inherit the parent event
event_inherited();
set_hp(75)

movemode = moveOrder.LINEAR
spr_icon = sprCultistIcon
//size = ENEMY_SIZE.SMALL;

with add_action("Slice") {	
	hit(10)
	//freeze(4);
}

with add_action("Incantation") {
	curse(12);
	block(6);
	//freeze(4);

}