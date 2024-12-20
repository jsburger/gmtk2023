

//So it doesnt bounce on the board when it uses the board staying script
bounciness = 0

gunangle = 0
friction = .5
sprite_index = sprHandIdleA

dash_timer = 0;
dash_direction = 0;

has_dice = false
can_shoot = false
die = -4;

portal = -4;

can_act = function() {
	with Board {
		if editor return false
		if !active return false
	}
	return true;
}