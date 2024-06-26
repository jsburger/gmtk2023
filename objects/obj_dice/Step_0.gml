if !canmove exit;
speed = clamp(speed + extraspeed, -maxspeed - extraspeed, maxspeed + extraspeed)

//Going down
if vspeed > 0 {
	gravity = gravity_base/1.2
}
//Going up
else {
	gravity = gravity_base
}
gravity *= nograv ? 0 : 1;

if (hit_timer && !--hit_timer){
	image_speed = clamp(0, image_speed - 1, 4);
	if(image_speed){
		hit_timer = 10;	
	}
}

extraspeed -= .07;
extraspeed = max(extraspeed, 0);

while(vspeed > max_fallspeed){
	speed -= .25;
}

//Portal reset
if portal > -4 && !place_meeting(x, y, portal){portal = -4}
if launcher > -4 && !place_meeting(x, y, launcher){launcher = -4}

if pierce <= 0 {
	image_blend = c_white;	
}
else {
	image_blend = c_red;	
}
