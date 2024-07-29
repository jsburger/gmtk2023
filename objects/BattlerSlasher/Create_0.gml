/// @description 

// Inherit the parent event
event_inherited();

set_hp(25)
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
	var damage = new DamageProvider(1, other, TARGETS.PLAYER);
	accept_provider(damage)
	set_intent(INTENT.ATTACK, damage)
	run(other.slash)
	hit(damage).delay = 10
	desc = "Die";
}
