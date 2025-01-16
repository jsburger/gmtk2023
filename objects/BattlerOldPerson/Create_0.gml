/// @description 

// Inherit the parent event
event_inherited();
set_hp(35)

movemode = moveOrder.RANDOM_STACK
spr_icon = sprOldPersonIcon
size = ENEMY_SIZE.SMALL;

var reduce = function(){
	mana_subtract_all(4)
}

with add_action("Lose") {
	hit(as_damage(6))
}

with add_action("Drain") {
	recolor(6, MANA_NONE)
	add_intent(new RecolorIntent(6, MANA_NONE))
		.with_desc("Uncolor 6 bricks.")
	buff_strength(2);
}
