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

add_action("Lose", function() {
	MOVESTART
	hit(as_damage(6))
	MOVEEND
})

add_action("Drain", function() {
	MOVESTART
	recolor(6, MANA_NONE)
	add_intent(new RecolorIntent(6, MANA_NONE))
		.with_desc("Uncolor 6 bricks.")
	buff_strength(2);
	MOVEEND
})
