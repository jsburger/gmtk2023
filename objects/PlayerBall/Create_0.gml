/// @description 

// Inherit the parent event
event_inherited();

pierce = 3;
damage = 1;
uses_extraspeed = true;

if juno {
	gravity_base = .15;
	pierce = 0;
}

hit_timer = 10;

on_board_bottom = function() {
	if (touchedBottom){
		if bbox_bottom > board_bottom + 128 {
			throw_end()
			instance_destroy()
			exit;
		}
	}
	else {
		touchedBottom += 1;
		if touchedBottom {
			with SafetyNet deactivate()
		}
		y = yprevious;
		vspeed = -5;
		on_dice_bounce(self);
		nograv = false
	}	
}