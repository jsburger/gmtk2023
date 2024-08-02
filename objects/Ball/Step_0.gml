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

if is_rolling() {
	image_speed = 0;
	if alarm[0] > 0 alarm[0] += 1;
	rotation += arc_length_to_degrees(speed, 25/2) * -sign(hspeed)
}
else if (hit_timer && !--hit_timer){
	image_speed = clamp(image_speed - 1, 0, 4);
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
if instance_exists(portal) && !place_meeting(x, y, portal) {
	portal = noone
}
if instance_exists(launcher) && !place_meeting(x, y, launcher) {
	launcher = noone
}

if pierce <= 0 {
	image_blend = c_white;	
}
else {
	image_blend = c_red;	
}
