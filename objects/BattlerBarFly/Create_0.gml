/// @description 

// Inherit the parent event
event_inherited();
set_hp(30)

movemode = moveOrder.RANDOM
spr_icon = sprBarFlyIcon

add_action("Numb", function() {
	MOVESTART
	block(8);
	freeze(6);
	MOVEEND
})

add_action("Rounds", function() {
	MOVESTART
	freeze(4)
	wait(5)
	poison(4)
	MOVEEND
})

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