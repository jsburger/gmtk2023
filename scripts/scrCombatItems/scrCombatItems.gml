function CombatItem() constructor {
	delay = 0;
	target = noone;
	owner = noone;
	
	static act = function(runner) {
		
	}
	
	static get_target = function() {
		if target != noone return resolve_target(target);
		return noone;
	}
	
}

function AttackItem(Damage) : CombatItem() constructor {
	delay = 15
	damage = Damage
	
	static act = function(runner) {
		var t = resolve_target(target)
		if instance_exists(t) {
			battler_hurt(t, provider_get(damage), owner)
		}
	}
}

function DefendItem(Block) : CombatItem() constructor {
	delay = 15
	block = Block
	
	static act = function(runner) {
		var t = resolve_target(target)
		if instance_exists(t) {
			battler_give_block(t, provider_get(block))
		}
	}
}

function WaitItem(duration) : CombatItem() constructor {
	delay = duration;
}

function StatusItem(_statusType, _strength) : CombatItem() constructor {
	delay = 15
	status = _statusType
	strength = _strength
	
	static act = function(runner) {
		var t = resolve_target(target)
		if instance_exists(t) {
			t.statuses.add_status(status, provider_get(strength))
		}
	}	
}

function FunctionItem(func) : CombatItem() constructor {
	self.func = func;
	delay = 0;
	
	static act = function(runner) {
		func()
	}
}

/// @ignore
function RecolorItem(count, color) : CombatItem() constructor {
	self.count = count;
	self.color = color;
	sorter = undefined;
	
	static act = function(runner) {
		var n = provider_get(count);
		if n > 0 {
			var c = bricks_recolor(n, provider_get(color), sorter)
			runner.waitTime += (__BRICK_RECOLOR_DELAY * (c - 1)) + 1;
		}
	}
}