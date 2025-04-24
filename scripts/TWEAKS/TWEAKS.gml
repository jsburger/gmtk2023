
// If the player uses yellow mana for their active or simply has a set amount of uses per turn
global.use_charges = true;
#macro USE_CHARGES global.use_charges

// Prevents dashing, but the safety net launches the ball much higher
global.no_dashes = true;
#macro NO_DASHES global.no_dashes

global.no_max_speed = true;
#macro NO_MAX_SPEED global.no_max_speed

global.smart_net = true;
#macro SMART_NET global.smart_net

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
	if keyboard_check_pressed(ord("4")) {
		SMART_NET = !SMART_NET;
	}
}


function CannonLaunchEffect() : BallEffect() constructor {
	leeway = 1;
	starting_pierce = 0;

	static on_apply = function(ball) {
		starting_pierce = ball.pierce;
		ball.pierce = infinity;
	}

	static on_remove = function(ball) {
		ball.pierce = starting_pierce;
	}
	
	static on_step = function(ball) {		
		if ball.vspeed >= 0 {
			if leeway <= 0 {
				clear();
			}
			else {
				leeway -= 1;
			}
		}
		if !ball.is_ghost {
			with instance_create_layer(ball.x, ball.y, "FX", obj_fx) {
				sprite_index = sprFXDust;
			}
		}
	}
}