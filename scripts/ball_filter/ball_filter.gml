/// Returns if the given ball can collide with the given brick
function ball_filter(ball, brick) {
	if !brick.can_ball_collide(ball) {
		return false;
	}
	if ball.is_ghost && brick.can_take_damage {
		//if array_contains(ball.ghost_pierce_list, brick.id) return false;
		if ((brick.hp / ball.damage) + brick.is_frozen) <= brick.ghost_hits return false;
	}
	return true;
}

function ball_can_damage(ball, brick) {
	return !(brick.id == ball.rolled_on_collider && ball.is_rolling())
}