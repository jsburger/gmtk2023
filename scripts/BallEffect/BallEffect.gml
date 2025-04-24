function BallEffect() constructor {
	wants_deletion = false;	
	
	static clear = function() { wants_deletion = true; }
	
	static on_apply = function(ball){};
	static on_remove = function(ball){};
	
	static on_impact = function(ball, hit_info) {};
	static on_shooter = function(ball, shooter) {};
	
	static on_step = function(ball) {};
	
	/// Called when effects are enabled during recalculation
	static on_reapply = function(ball) {
		on_apply(ball)
	}
	/// Called when effects are disabled during recalculation
	static on_refresh = function(ball) {
		on_remove(ball);
	}
}


#macro juno global.juno_mode
juno = true;

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
		if can_boost {
			ball.bounce_speed = ball.bounce_speed_base;
			ball.vspeed = 2 * ball.bounce_speed;
			can_boost = false;
		}
		else clear()
	}
	
}