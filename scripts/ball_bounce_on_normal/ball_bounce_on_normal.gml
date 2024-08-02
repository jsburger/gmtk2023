function ball_bounce_on_normal(ball, brick, normal) {
	with ball {
		var dot = abs(vector_get_length_on_axis(speed, direction, normal)),
			cor = (1 + (ball.bounciness * brick.bounciness));
		motion_add(normal, dot * cor)
	}
}