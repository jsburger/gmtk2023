
// If the player uses yellow mana for their active or simply has a set amount of uses per turn
global.use_charges = true;
#macro USE_CHARGES global.use_charges

// Prevents dashing, but the safety net launches the ball much higher
global.no_dashes = true;
#macro NO_DASHES global.no_dashes

global.no_max_speed = true;
#macro NO_MAX_SPEED global.no_max_speed

function tweaks_step() {
	if keyboard_check_pressed(ord("1")) {
		USE_CHARGES = !USE_CHARGES;
	}
	if keyboard_check_pressed(ord("2")) {
		NO_DASHES = !NO_DASHES;
	}
	if keyboard_check_pressed(ord("3")) {
		NO_MAX_SPEED = !NO_MAX_SPEED;
	}
}


function CannonLaunchEffect() : BallEffect() constructor {
	static on_step = function(ball) {
		with ball {
			if vspeed < 0 {
				pierce = max(pierce, 1);
			}
			else {
				other.clear();
			}
		}
		if chance(1, 10) {
			with instance_create_layer(ball.x, ball.y, "FX", obj_fx) {
				sprite_index = sprFXDust;
			}
		}
	}
}