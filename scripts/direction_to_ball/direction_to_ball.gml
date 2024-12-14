function direction_to_ball(ball, inst) {
	return point_direction(
		clamp(ball.x, inst.bbox_left, inst.bbox_right), clamp(ball.y, inst.bbox_top, inst.bbox_bottom),
		ball.x, ball.y
	);
}