function Spell() : CombatInterface() constructor {
	
	is_instant = false;
	costs = array_create(MANA.MAX);
	
	name = "Spell";
	desc = "Description";
	
	sprite_index = sprChip;
	
	use_max = infinity;
	uses = use_max;
	
	can_cancel = true;
	triggers_reactions = true;
	
	modified_costs = new FrameCache(function() {
		return calculate_spell_cost(self);
	})
	
	static act = function() {};
	
	static on_mount = function() {};
	
	/// Called between rounds to reset uses
	static reset = function() {
		uses = use_max;
	}
	
	static set_cost = function(type, amount) {
		costs[type] = amount
	}
	static set_costs = function(red = 0, blue = 0, yellow = 0) {
		costs[MANA.RED] = red
		costs[MANA.BLUE] = blue
		costs[MANA.YELLOW] = yellow
	}
	
	static set_uses = function(n) {
		uses = n;
		use_max = n;
	}
	
	static cast = function() {
		act();
		after_cast();
		done();
	}
	
	static can_cast = function() {
		if uses <= 0 return false;
		var costs = modified_costs.get();
		for (var i = 0; i < MANA.MAX; ++i) {
		    if global.mana[i] < costs[i] return false
		}
		return can_cast_modifier();
	}
	
	static can_cast_modifier = function() { return true; }
	
	static spend_mana = function() {
		var costs = modified_costs.get();
		for (var i = 0; i < MANA.MAX; ++i) {
		    global.mana[i] -= costs[i]
		}
	}
	
	/// Where mana is spent and uses are decremented.
	static after_cast = function() {
		if uses > 0 {
			uses -= 1;
		}
		spend_mana();
	}
	
	/// Called while it is CombatRunner.current_spell
	static active_draw = function() {}
	
	/// Called while it is CombatRunner.current_spell
	static active_step = function() {}
	
	/// Run when the mouse clicks
	static on_click = function() {}
	static on_hold = function(last_x, last_y) {}
	static on_release = function() {}
	
	/// Called when spell is cancelled or cast (when it stops being active)
	static clear = function() {};
	/// Call to mark a spell as "done", signalling CombatRunner to clear it and proceed with running.
	static done = function() {
		CombatRunner.spell_finish();
	};
}