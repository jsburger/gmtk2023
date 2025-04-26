/// @description 

// Inherit the parent event
event_inherited();
set_hp(40)

movemode = moveOrder.RANDOM_STACK
spr_icon = sprSentryIcon

add_action("Attack", function() {
	MOVESTART
	hit(as_damage(8))
	MOVEEND
})

add_action("Drain", function() {
	MOVESTART
	recolor(6, MANA_NONE)
	add_intent(new RecolorIntent(6, MANA_NONE))
		.with_desc("Uncolor 6 bricks.")
	MOVEEND
})
