/// @description 

// Inherit the parent event
event_inherited();

pierce = 3;
damage = 1;
uses_extraspeed = true;

hit_timer = 10;

on_board_bottom = function() {
	if (touchedBottom){
		if bbox_bottom > board_bottom + 128 {
			if !is_ghost {
				throw_end();
			}
			instance_destroy()
			exit;
		}
	}
	else if bbox_bottom > board_bottom + 10 {
		touchedBottom += 1;
		if touchedBottom {
			if !is_ghost {
				with SafetyNet deactivate()
			}
		}
		y += (board_bottom - bbox_bottom) - vspeed;
		vspeed = -6;
		if NO_DASHES {
			vspeed *= 4;
			effects.add_effect(self, new CannonLaunchEffect())
		}
		if SMART_NET {
			motion_set(point_direction(x, y, mouse_x, mouse_y), speed);
		}
		on_dice_bounce(self);
		nograv = false
	}	
}