/// @description 

// Inherit the parent event
event_inherited();

launch_direction = 90;
spr_idle = sprLauncherIdle;
spr_launch = sprLauncherFire;

set_launch_direction = function(dir) {
	launch_direction = dir;
	image_angle = dir - 90;
}

serializer.add_var_layer(self, "launch_direction", set_launch_direction);

can_walk_back_ball = false;
ball_bounce = function(ball) {
	if (ball.launcher != id) {
		ball.launcher = id;
		with ball {
			x = other.x;
			y = other.y;
			motion_set(other.launch_direction, maxspeed)
		}
		ball.just_launched = true;
		ball.nograv = true;
	}
}

on_ball_impact = function(ball, collision_x, collision_y) {
	if ball.just_launched {
		ball.just_launched = false;
		instance_create_layer(ball.x, ball.y, "FX", obj_hit_small);
		var sound = ball.is_coin ? sndBumperHitQuiet : sndBumperHit;
		sound_play_random(sound)
		sprite_change(spr_launch)
	}
}