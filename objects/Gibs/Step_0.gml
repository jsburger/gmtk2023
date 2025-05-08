speed = clamp(speed, -maxspeed, maxspeed)

//Going down
if vspeed > 0 {
	gravity = gravity_base/1.2
}
//Going up
else {
	gravity = gravity_base
}
if (hit_timer && !--hit_timer){
	image_speed = clamp(0, image_speed - 1, 4);
	if(image_speed){
		hit_timer = 10;	
	}
}

//Landing on the ground
if (bbox_bottom >= Board.bbox_bottom-sprite_height/2){
	event_perform(ev_other, ev_user0);
}

//Portal reset
if instance_exists(portal) && !place_meeting(x, y, portal) {
	portal = noone;
}
//Decide rolled value 
if landed{
	fade--;
	var _frequency = 7;
	if fade <= room_speed{
		image_alpha = (fade mod _frequency >= (_frequency / 2));
	}
	if fade <= 0{
		instance_destroy();
		exit;
	}
}else fade = maxfade;