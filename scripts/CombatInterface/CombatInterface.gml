function CombatInterface() constructor {
	
	owner = noone;
	
	static set_owner = function(source) {
		owner = source;
		return self;
	}
	
	static consume = function(item) {
		CombatRunner.enqueue(item)
	}


	static attack = function(_target, damage) {
		var act = new AttackItem(_target, damage, owner)
		consume(act)
		return act;
	}
	
	static defend = function(_target, amount) {
		var act = new DefendItem(_target, amount, owner)
		consume(act)			
	}
	
	/// @func block
	/// Gives block to self
	static block = function(amount) {
		defend(TARGETS.SELF, amount)
	}
	
	static apply_status = function(_target, statusType, statusStrength = 1) {
		var act = new StatusItem(_target, statusType, statusStrength, owner);
		consume(act)
	}
	
	
	static wait = function(duration) {
		consume(new WaitItem(duration, owner))
	}
	
	static effect = function(_target, sprite) {
		
	}
	
	/// Tries to cast the given method to the owner of this interface.
	/// Does nothing if the method is determined to be intentionally scoped to something else.
	static recast_func = function(func) {
		if instance_exists(owner) {
			var convert = true;
			if is_method(func) && method_get_self(func) != self {
				convert = false;
			}
			if convert {
				func = method(owner, func);
			}
		}
		return func;
	}
	
	static run = function(func) {
		func = recast_func(func);
		var act = new FunctionItem(owner, func);
		consume(act)
		return act;
	}
	
	/// @func recolor
	static recolor = function(count, _color) {
		var act = new RecolorItem(count, _color, owner);
		consume(act);
		return act;
	}

	static curse = function(count) {
		var act = new FunctionItem(owner, anonymous(bricks_curse), count);
		consume(act);
		return act;
	}

	static raw = function(func) {
		var act = new RawCombatItem(owner, func);
		consume(act);
		return act;
	}

}
