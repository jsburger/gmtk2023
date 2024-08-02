function ball_bounce_on_normal(ball, brick, normal) {
	with ball {
		motion_add(normal, abs(vector_get_length_on_axis(speed, direction, normal)) * (1 + (ball.bounciness * brick.bounciness)))
	}
}