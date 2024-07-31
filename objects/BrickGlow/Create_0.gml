/// @description 

// Inherit the parent event
event_inherited();

fullclear_ignore = false;
can_take_damage = true;
hp = 9999;
on = true;
spr_off = sprBrickGlowOff;

setup_freeze(sprBrickOverlayFrozen)

on_ball_impact = function(ball, collision_x, collision_y) {
	
	instance_create_layer(collision_x, collision_y, "FX", obj_hit_small);
	
	if on == true {
		
		if is_valid_mana(color) {
			mana_give_at(x, y, color, mana_amount);
		}
		sprite_index = spr_off;
		on = false;	
		fullclear_ignore = true;
		sound_play_random(sndCoinBig);
	}
	else {
		sound_play_random(sndDieHitMetal);	
	}
	
}