/// @description Movement and Chip shooting

if keyboard_check_pressed(ord("Q")) bricks_curse(3);

var can_act = self.can_act(),
	inBoard = false;
if instance_exists(Board) {
	inBoard = point_in_rectangle(mouse_x, mouse_y, board_left, board_top, board_right, board_bottom)
}
if (can_act) {
	var acceleration = 1,
		maxspeed = 6;

	if button_check(inputs.left) {
		hspeed -= acceleration
	}
	else if button_check(inputs.right) {
		hspeed += acceleration
	}
	speed = clamp(speed, -maxspeed, maxspeed)
}

gunangle = point_direction(x, y, mouse_x, mouse_y);
if gunangle > 180{
	if gunangle > 270{
		gunangle = 0;	
	}else gunangle = 180;
}

//image_xscale = ((gunangle + 270) % 360) < 180 ? -1 : 1;
//image_angle = gunangle - 90;

#macro chip_cost 1

if can_act && button_pressed(inputs.shoot) && can_shoot {
	//Shoot chips
	if instance_exists(die) {
		//Zone where chips cannot be shot to stop people from wasting chips
		if (abs(die.y - Board.bbox_bottom) >  55) && (global.mana[MANA.YELLOW] > 0) {
			with instance_create_layer(x, y, "Projectiles", obj_chip) {
				motion_set(other.gunangle, 16)
				global.mana[MANA.YELLOW] -= chip_cost
			}
			sound_play_pitch(choose(sndChipThrow1, sndChipThrow2), 1)
			sprite_index = sprHandThanosSnap;
			image_index = 0;
			with obj_cuffs {
				sprite_index = sprCuffsFire
				image_index = 0
			}
		}
	}
	//Shoot dice
	else if inBoard {
		with instance_create_layer(x, y, "Projectiles", Ball) {
			motion_set(other.gunangle, 18)
			other.die = id;
		}
			
		sound_play_pitch(sndDieThrow, 1)
		sprite_index = sprHandThrow;
		has_dice = false
		image_index = 0;
		throw_start()
		with obj_cuffs {
			sprite_index = sprCuffsFire
			image_index = 0
		}
	}
}

// Dash
var _input = button_check(inputs.right) - button_check(inputs.left)
if can_act && button_pressed(inputs.dash) && dash_timer <= 10 && _input != 0 {
	dash_timer = 20;
	dash_direction = _input;
	sound_play_pitch(choose(sndDash1, sndDash2), 1);
	if !has_dice{
		sprite_index = sprHandDash;
		image_index = 0;
	}
}
if (--dash_timer){
	with instance_create_depth(x, random_range(bbox_top, bbox_bottom), depth + 1, obj_dash){
		image_speed *= random_range(.9, 1.2);
		motion_add(other.direction, random(1) * -1);
	}
	hspeed = sign(dash_direction) * 15;
}

//Portal reset
if portal > -4 && !place_meeting(x, y, portal)portal = -4;



//Fake Spell Casting
if keyboard_check_pressed(ord("1")){
	sound_play_pitch(sndExplosion, .7);
	scr_screenshake(10, 3, 0.2);
}

if keyboard_check_pressed(ord("2")){
	sound_play_pitch(sndBumperHit, .7);
	scr_screenshake(10, 3, 0.2);
}

if keyboard_check_pressed(ord("0")){
	scr_screenshake(10, 3, 0.2);
	mana_reset()
}