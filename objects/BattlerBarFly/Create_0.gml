/// @description 

// Inherit the parent event
event_inherited();
set_hp(30)

movemode = moveOrder.RANDOM
spr_icon = sprBarFlyIcon

with add_action("Numb") {
	set_intent(INTENT.BLOCK, 8)
	defend(TARGETS.SELF, 8)
	freeze(6)
	
	desc = "Add 8 Shield to self.\nApply 6 Freeze."
}

with add_action("Rounds") {
	set_intent(INTENT.DEBUFF, 4)
	freeze(4)
	wait(5)
	poison(4)
	
	desc = "Apply 4 Freeze.\nApply 4 Poison."
}

