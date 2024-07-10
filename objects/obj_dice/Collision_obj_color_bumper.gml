/// @description give mana
var dir = point_direction(other.x, other.y, x, y);
motion_set(dir, speed)
move_outside_all(dir, 8)
instance_create_layer((x + other.x) / 2, (y + other.y) / 2, "FX", obj_hit_small);
//extraspeed = 3;
nograv = false;

if other.active == true {	
	other.sprite_index = sprColorBumperHit;
	other.image_index = 0;
	sound_play_pitch(sndCoinBig, random_range(.8, 1.2));
	
	other.bounces--;
	
	if other.color > -1 {
		mana_add(other.color, other.mana_amount)
		repeat(other.mana_amount) mana_effect_create(other.x, other.y, other.color)
	}
}
else {
	sound_play_pitch(sndDieHitMetal, random_range(.8, 1.2));
}


on_dice_bounce(self)
