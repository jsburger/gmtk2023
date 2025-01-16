/// @description 

// Inherit the parent event
event_inherited();
set_hp(30)

movemode = moveOrder.RANDOM
spr_icon = sprBarFlyIcon

with add_action("Numb") {
	block(8);
	freeze(6);
}

with add_action("Rounds") {
	freeze(4)
	wait(5)
	poison(4)
}

/* example
with add_action("Slap") {
	desc = "Deal 3 damage to all other enemies.\nGain 100 block";
	multitarget(TARGETS.OTHER_ENEMIES, function(target) {
		var damage = as_damage(3);
		attack(target, damage)
	})
	block(100)
}
*/