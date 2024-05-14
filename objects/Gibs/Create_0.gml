
bounciness = .8
gravity_base = .26
gravity = gravity_base
//friction = .03
hit_timer = 0;
maxspeed = 16
image_speed = 0;
image_index = random(image_number);
touchedBottom = false;
landed = false;
maxfade = round(room_speed * 2);
fade = maxfade;
portal = -4;
//sound = snd_coin
board_bottom_bounce = -(1 + image_index);
depth -= 2;
lastcollision = {"x": x, "y": y}

alarm[0] = 1;