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

function StatusItem(_statusType, _duration, _strength) : CombatItem() constructor {
	delay = 15
	status = _statusType
	duration = _duration
	strength = _strength
	
	static act = function(runner) {
		var t = resolve_target(target)
		if instance_exists(t) {
			t.statuses.add(new status(provider_get(duration), provider_get(strength)))
		}
	}	
}

function FunctionItem(func) : CombatItem() constructor {
	self.func = func;
	
	static act = function(runner) {
		func()
	}
}
