/// @description 

// Inherit the parent event
event_inherited();

stops_preview = false;

launch_direction = 90;

set_launch_direction = function(dir) {
	launch_direction = dir;
	image_angle = dir - 90;
}

serializer.add_var_layer(self, "launch_direction", set_launch_direction);

can_ball_collide = function(ball) {
	if ball.is_coin return false;
	return ball.launcher != id;
}
can_walk_back_ball = false;
ball_bounce = function(ball) {
	
	//ball.nograv = true;
	ball.launcher = id;
	with ball {
		x = other.x;
		y = other.y;
		motion_set(other.launch_direction, maxspeed)
	}
}

on_ball_impact = function(ball, collision_x, collision_y) {
	with instance_create_layer(x, y, "FX", obj_hit_small){
		sprite_index = sprFXPuffMedium	
		image_angle = 0
	}
	var sound = ball.is_coin ? sndBumperHitQuiet : sndExplosion;
	sound_play_random(sound)
	scr_screenshake(3, 1, 0.2);
	instance_destroy()
}