/// @description 

// Inherit the parent event
event_inherited();
set_hp(40)

movemode = moveOrder.RANDOM_STACK
spr_icon = sprSentryIcon

with add_action("Attack") {
	hit(as_damage(8))
}

with add_action("Drain") {
	recolor(6, MANA_NONE)
	add_intent(new RecolorIntent(6, MANA_NONE))
		.with_desc("Uncolor 6 bricks.")
}
