/// @description Stay inside board
// You can write your code in this editor
if !canmove exit;
if (instance_exists(Board)) {
	if bbox_bottom > Board.bbox_bottom{
		if (touchedBottom){
			if bbox_bottom > Board.bbox_bottom + 128{
				if object_index == Ball {
					throw_end()
					instance_destroy()
					exit;
				}
				else {
					y = yprevious;
				}
			}
		}
		else {
			if ++touchedBottom {
				with SafetyNet deactivate()
			}
			y = yprevious;
			vspeed = -5;
			on_dice_bounce(self);
			nograv = false
		}
	}
}

//True when bouncing
if stay_inside_board() {
	sound_play_pitch(sndDieHitWall, random_range(.9, 1.1))
	extraspeed = 0;
	nograv = false;
}

// When the dice explodes. Anti-softlock check
if image_blend = c_dkgray{
	if random(6) < 1{
		with(instance_create_layer(x, y, "Projectiles", obj_hit_medium)){
			x += random_range(-8,8);
			y += random_range(-8,8);
		}
	}
	nograv = false;
	portal = instance_place(x, y, portal)
}