/// @description 

// Inherit the parent event
event_inherited();
shuffle;

save_rotation;

can_take_damage = false;
snd_impact = sndDieHitMetal;

ball_bounce = function(ball) {
	var normal = image_angle + 90;
	ball_bounce_on_normal(ball, self, normal);
}

can_ball_collide = function(ball) {
	var normal = image_angle + 90,
		dot = vector_get_length_on_axis(ball.speed, ball.direction, normal)/ball.speed;
		
	var dir = direction_to_ball(ball, self),
		position_dot = vector_get_length_on_axis(1, dir, normal);
	return dot <= 0 && position_dot >= 0;
}

on_ball_impact = method(self, impact_normal);