/// @description 

// Inherit the parent event
event_inherited();

mana_amount = 1;
colorable = true;
color = COLORS.NONE;

set_color = function(col) {
	if !is_valid_color(col) exit
	color = col
	image_blend = mana_get_color(col)
}

rotates = false;

is_coin = true;
damage = 0;

spr_hit = sprTokenFall;

fade = 0;
fade_max = 1 sec;

bounce_speed = -5;
bounciness = .8;
image_speed = 1;
has_landed = false;

uses_extraspeed = false;

on_bounce = function() {
	if speed < 4 {
		vspeed = -4;
		if abs(hspeed) < .1 {
			hspeed = choose(-1, 1)
		}
	}
}

on_board_bottom = function() {
	y += board_bottom - bbox_bottom;
	vspeed = bounce_speed;
	hspeed /= 2;
	has_landed = true;
	
}