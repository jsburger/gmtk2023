/// @ignore
function JunoCharacter() : Character("Juno") constructor {
	set_sprites(sprJunoIdle, sprJunoFire);
	
	shooter = JunoShooter;
	ball = JunoBall;
	
	bg_color = #89db70
}

function JunoEffect() : BallEffect() constructor {
	can_boost = true;
	
	static on_apply = function(ball) {
		ball.damage += 3;
		ball.max_fallspeed += 6;
		ball.gravity_base += .1;
	}
	static on_remove = function(ball) {
		ball.damage -= 3;
		ball.max_fallspeed -= 6;
		ball.gravity_base -= .1;
	}
	
	static on_impact = function(ball, hit_info) {
		if !hit_info.pierced {
			clear();
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
		clear();
	}
	
}