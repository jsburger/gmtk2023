/// @description 

// Inherit the parent event
event_inherited();

set_hp(25)
spr_icon = sprSlasher
movemode = moveOrder.LINEAR
move_max = 8;
arm = instance_create_depth(x - 24, y + 32, depth - 1, Blank);
with arm {
	sprite_index = sprSlasherKnife
}

slash = function() {
	arm.image_angle = 90
}

with add_action("Slash") {
	var damage = new DamageProvider(3, other, TARGETS.PLAYER);
	accept_provider(damage)
	set_intent(INTENT.ATTACK, damage)
	run(other.slash)
	hit(damage).delay = 10
}
