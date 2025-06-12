function bounce_rectangular(ball) {
	var collision = {x: clamp(ball.x, bbox_left, bbox_right), y: clamp(ball.y, bbox_top, bbox_bottom)};

	var dir = point_direction(collision.x,collision.y, ball.x, ball.y);
	ball_bounce_on_normal(ball, self, dir);
	
}

function impact_normal(ball, collision_x, collision_y) {
	if !ball.is_coin sound_play_random(snd_impact)
	
	instance_create_layer(collision_x, collision_y, "FX", obj_hit_small);
}

function bounce_circular(ball) {
	var	dir = point_direction(x, y, ball.x, ball.y);
	
	ball_bounce_on_normal(ball, self, dir)
	
}