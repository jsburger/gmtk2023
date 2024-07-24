/// @description 

// Inherit the parent event
event_inherited();
shuffle;

spr_idle = sprBumper;
spr_hit = sprBumperHit;

ball_bounce = function(ball) {
	var dir = point_direction(x, y, ball.x, ball.y);
	with ball motion_set(dir, speed);
	ball.extraspeed = 3;
}

on_ball_impact = function(ball, collision_x, collision_y) {
	sprite_change(spr_hit)
	
	instance_create_layer(collision_x, collision_y, "FX", obj_hit_small);
	var sound = ball.is_coin ? sndBumperHitQuiet : sndBumperHit;
	sound_play_pitch(sound, random_range(.8, 1.2));
}
