/// @description 

// Inherit the parent event
event_inherited();

set_hp(30)
spr_icon = sprSlasherIcon
movemode = moveOrder.LINEAR
move_max = 20;
arm_pos = {x: -24, y: 32}
arm = instance_create_depth(x + arm_pos.x, y + arm_pos.y, depth - 1, Blank);
with arm {
	sprite_index = sprSlasherKnife
}

slash = function() {
	arm.image_angle = 70
}

with add_action("Slash") {
	run(other.slash)
	hit(as_damage(1)).delay = 10
	last_intent().desc = "Die";
	last_intent().value = undefined;
}
