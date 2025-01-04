/// @description 

// Inherit the parent event
event_inherited();

bounces = 5;
bounces_max = bounces;
spr_idle = sprColorBumperIdle;
spr_hit = sprColorBumperHit;

colorable = true;
mana_amount = 1;

granted_extraspeed = 0;

super = {
	on_ball_impact,
	set_color
};

base_color = image_blend;
set_color = function(col) {
	super.set_color(col)
	base_color = image_blend;
	update_color()
}

update_color = function() {
	image_blend = merge_color(base_color, c_dkgray, 1 - (bounces/bounces_max));
}

on_ball_impact = function(ball, collision_x, collision_y) {	
	
	instance_create_layer(collision_x, collision_y, "FX", obj_hit_small);

	if !ball.is_coin {
		if bounces > 0 {
			if is_valid_mana(color) {
				bounces -= 1;
				update_color();
				mana_give_at(x, y, color, mana_amount);
			}
			sprite_change(spr_hit)
			sound_play_random(sndCoinBig);
		}
		else {
			sound_play_random(sndDieHitMetal);
		}
	}
}