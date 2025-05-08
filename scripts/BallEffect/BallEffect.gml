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