/// @ignore
function JunoCharacter() : Character("Juno") constructor {
	set_sprites(sprJunoIdle, sprJunoFire);
	
	shooter = JunoShooter;
	ball = JunoBall;
	
	//get_juno_spells() <= middle click for quick access
	starting_spells = [
		SPELLS.SLAMMY, SPELLS.BLOCKO,
		SPELLS.JUNO.PLACERS.PROBE, SPELLS.PLACERS.BARREL,
		SPELLS.REDIFY, SPELLS.REVIVE];
	
	bg_color = #89db70;
}

function JunoEffect() : BallEffect() constructor {
	can_boost = true;
	
	stat_changes = [
		//new StatChange("damage", 3),
		new StatChange("max_fallspeed", 2),
		new StatChange("gravity_base", 5)
	];
	
	static can_infinite_pierce = function(ball, brick) { return true; };
	
	static on_apply = function(ball) {
		ball.has_juno_boost = true;
	}
	static on_remove = function(ball) {
		ball.has_juno_boost = false;
	}
	
	static on_impact = function(ball, hit_info) {
		if !hit_info.pierced {
			clear();
		}
	}
	
	leeway = 1;
	
	static on_step = function(ball) {
		if !ball.is_ghost {
			with instance_create_layer(ball.x, ball.y, "FX", obj_fx) {
				sprite_index = sprFXFireSmall;
			}
		}
	}
	
	static on_shooter = function(ball, shooter) {
		//if can_boost {
		//	ball.bounce_speed = ball.bounce_speed_base;
		//	ball.vspeed = 2 * ball.bounce_speed;
		//	can_boost = false;
		//}
		//else clear()
		
		ball.effects.add_effect(ball, new CannonLaunchEffect());
		ball.speed *= 2;
		if !ball.is_ghost sleep(200); //Idk man
		clear();
	}
	
}


function CannonLaunchEffect() : BallEffect() constructor {
	leeway = 1;
	
	static can_infinite_pierce = function(ball, brick) {
		return true;
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