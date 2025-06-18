function BallEffect() constructor {
	wants_deletion = false;	
	
	stat_changes = [];
	
	static clear = function() { wants_deletion = true; }
	
	static on_apply = function(ball){};
	static on_remove = function(ball){};
	
	static on_impact = function(ball, hit_info) {};
	static on_shooter = function(ball, shooter) {};
	
	static on_step = function(ball) {};
	
	static can_infinite_pierce = function(ball, brick) { return false; };
	
	/// Called when effects are enabled during recalculation
	static on_reapply = function(ball) {
		on_apply(ball)
	}
	/// Called when effects are disabled during recalculation
	static on_refresh = function(ball) {
		on_remove(ball);
	}
}

function StatChange(variable, value) constructor {
	self.variable = variable;
	self.value = value;
	
	static apply = function(instance) {
		variable_instance_set(instance, variable, variable_instance_get(instance, variable) + value);
	}
	static reverse = function(instance) {
		variable_instance_set(instance, variable, variable_instance_get(instance, variable) - value);
	}
}

function StatChangeMultiply(variable, value) : StatChange(variable, value) constructor {
	static apply = function(instance) {
		variable_instance_set(instance, variable, variable_instance_get(instance, variable) * value);
	}
	static reverse = function(instance) {
		variable_instance_set(instance, variable, variable_instance_get(instance, variable) / value);
	}
}