/// @description Dash into die
if(other.image_blend != c_dkgray){
	other.nograv = false;
	if (dash_timer){
		
		with(other){
			instance_create_layer(x, y, "FX", obj_hit_large)
			vspeed = bounce_speed;
			bounce_speed = (bounce_speed * 0.8);
			hspeed = sign(other.hspeed) * 2;
			sound_play_pitch(choose(sndDashHit1, sndDashHit2), random_range(.9, 1.1));
			on_dice_bounce(self);
			y -= 10
			//maxspeed += 0.5;
			//max_fallspeed += 0.5;
			//gravity_base += .01;
			//bounciness -= 0.1;
			effects.on_shooter(self, other)
		}
		dash_timer = 0;
	}
}