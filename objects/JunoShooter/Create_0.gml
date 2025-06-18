/// @description 

// Inherit the parent event
event_inherited();

// Standard Sprites
spr_hold = sprJunoShooterHold;
spr_idle = sprJunoShooterIdle;
spr_throw = sprJunoShooterHold;
spr_dash = sprJunoShooterHold;

spr_dice = sprJunoBall;

active = function() {
	with die {
		effects.add_effect(self, new JunoEffect())
		vspeed = max_fallspeed * .8;
		//pierce += 2;
		with instance_create_layer(x, y, "FX", obj_fx) {
			sprite_index = sprFXJuno;
		}
		if instance_exists(JunoProbe) {
			direction = point_direction_struct(self, instance_nearest(x, y, JunoProbe));
			speed = maxspeed;
			nograv = true;
		}
		return true;
	}
	return false;
}


has_dash = true;
on_refresh = function() {
	has_dash = true;
}