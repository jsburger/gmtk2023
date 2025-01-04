event_inherited();

bounciness = 1;
//Was .25, changed when removing friction
gravity_base = .26
gravity = gravity_base
//friction = .03
maxspeed = 14
max_fallspeed = 7;
extraspeed = 0;
hit_timer = 0;
damage = 1;
image_speed = 3;
alarm[0] = 10
landed = false;
touchedBottom = false;
nograv = false;
spr_hit = sprDiceHit;
has_bounced = false;
pierce = 0;
bounce_speed = -12;
rotates = true;

previous_acceleration = 0;

patience_enable = false;
last_bounce_coords = [x,y];
last_bounce_patience = 16;
last_bounce_patience_frame = current_time;

portal = noone;
launcher = noone;

canmove = true;

rotation = 0; //Visual only image_angle

is_coin = false;
is_ghost = false; //Used for ball preview
uses_extraspeed = true;

is_rolling = function() {
	return abs(vspeed) < 2 && instance_exists(rolled_on_collider) && distance_to_object(rolled_on_collider) < 5;
}
rolled_on_collider = noone;

on_board_bottom = function() {}

apply_extraspeed = function(n) {
	if uses_extraspeed && n > 0 {
		extraspeed = max(n, extraspeed);
		alarm[1] = 1;
	}
}

on_bounce = function() {}
