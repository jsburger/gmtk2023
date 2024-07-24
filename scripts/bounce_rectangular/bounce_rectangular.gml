function bounce_rectangular(ball) {
	var collision = {x: clamp(ball.x, bbox_left, bbox_right), y: clamp(ball.y, bbox_top, bbox_bottom)};

	var dir = point_direction(collision.x,collision.y, ball.x, ball.y);
	with ball {
		motion_add(dir, vector_get_length_on_axis(speed, direction, dir + 180) * 2)
		//JANK
		if (vspeed < 0 && speed > 2) vspeed = min(vspeed, -4);
	}
	
}

function impact_normal(ball, collision_x, collision_y) {
	if !ball.is_coin sound_play_random(snd_impact)
	
	instance_create_layer(collision_x, collision_y, "FX", obj_hit_small);
}