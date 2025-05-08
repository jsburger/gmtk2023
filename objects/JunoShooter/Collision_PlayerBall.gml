/// @description 

if (has_dash && dash_timer > 0) {
	var ball = other;
	
	if ball.image_blend != c_dkgray {
		has_dash = false;
		
		ball.nograv = false;
		
		with ball {
			instance_create_layer(x, y, "FX", obj_hit_large);
			//y -= 10;
			motion_set(point_direction(other.x, other.y, mouse_x, mouse_y), other.throw_speed/1.2);
			sound_play_random(sound_pool(sndDashHit1));
			on_dice_bounce(self);
			
			effects.on_shooter(self, other);
		}
	}
	dash_timer = 0;
}