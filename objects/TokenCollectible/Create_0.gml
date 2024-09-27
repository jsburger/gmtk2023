
bounciness = .8
gravity_base = .26
gravity = gravity_base
//friction = .03
hit_timer = 0;
maxspeed = 16
image_speed = 1;
landed = false;
maxfade = round(room_speed);
fade = maxfade;
portal = -4;
sound = sndCoin
board_bottom_bounce = -5;
depth -= 2;

mana_amount = 1;
colorable = true;
color = MANA_NONE;

set_color = function(col) {
	if !is_valid_color(col) exit
	color = col
	image_blend = mana_get_color(col)
}

lastcollision = {"x": x, "y": y}