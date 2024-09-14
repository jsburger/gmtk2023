/// @description 

// Inherit the parent event
event_inherited();
set_hp(40)

movemode = moveOrder.RANDOM
spr_icon = sprBarFlyIcon

with add_action("Numb") {
	set_intent(INTENT.BLOCK, 8)
	defend(TARGETS.SELF, 8)
	freeze(8)
	
	desc = "Add 8 Shield to a random enemy.\nApply 8 Freeze."
}

with add_action("Rounds") {
	set_intent(INTENT.DEBUFF, 6)
	freeze(3)
	wait(5)
	poison(6)
	
	desc = "Apply 3 Freeze.\nApply 6 Poison."
}

