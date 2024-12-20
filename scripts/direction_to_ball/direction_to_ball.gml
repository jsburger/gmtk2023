/// Returns direction to the ball from a bounding box
function direction_to_ball(ball, inst) {
	return point_direction(
		clamp(ball.x, inst.bbox_left, inst.bbox_right), clamp(ball.y, inst.bbox_top, inst.bbox_bottom),
		ball.x, ball.y
	);
}

function direction_to_shooter(_x, _y) {
	if instance_exists(Shooter) {
		return point_direction(_x, _y, Shooter.x, Shooter.y);
	}
	return 270;
}