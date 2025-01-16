/// @description 

// Inherit the parent event
event_inherited();
set_hp(30)

movemode = moveOrder.RANDOM_STACK
spr_icon = sprGermIcon
size = ENEMY_SIZE.SMALL;


with add_action("Yuck") {
	poison(6);
}
