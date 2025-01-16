/// @description 

// Inherit the parent event
event_inherited();
set_hp(50)

movemode = moveOrder.LINEAR
spr_icon = sprSingerIcon

with add_action("Scream") {
	hit(as_damage(1))
	buff_strength(5)
}
