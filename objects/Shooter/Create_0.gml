

//So it doesnt bounce on the board when it uses the board staying script
bounciness = 0

gunangle = 0
friction = .5

spr_hold = sprHandIdleA;
spr_idle = sprHandIdleB;
spr_throw = sprHandThrow;
spr_dash = sprHandDash;
spr_dice = sprDiceIdle;

dash_timer = 0;
dash_direction = 0;

has_dice = false
can_shoot = false
die = instance_nearest(0, 0, PlayerBall);
die = noone

portal = noone;

throw_speed = 14;

active_charges = 3;

can_act = function() {
	with Board {
		if editor return false
		if !active return false
	}
	return true;
}

/// Called when the throw starts and the shooter is given a die to throw
on_refresh = function() {}

/// Returns if the shooter should spend resources
active = function() {
	return true;
}