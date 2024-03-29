function CombatInterface() constructor {
	
	owner = noone;
	
	static set_owner = function(source) {
		owner = source;
		return self;
	}
	
	static consume = function(item) {
		CombatRunner.enqueue(item)
	}
	
	static resolve_target = function(target) {
		if instance_exists(target) return target
		if is_struct(target) {
			return struct_defget(target, "instance", noone)
		}
		if is_real(target) {
			return get_item_target(target)
		}
		return noone
		
	}

	static attack = function(_target, damage, times = 1, useStrength = true) {
		if useStrength {
			if instance_exists(owner) {
				damage += owner.statuses.get_attack_bonus()
			}
		}
		
		repeat(times) {
			var act = new AttackItem(damage)
			act.target = resolve_target(_target)
			act.owner = owner;
			consume(act)
		}
	}
	
	
	static give_status = function(_target, statusType, statusDuration = 1, statusStrength = 1) {
		var act = new StatusItem(statusType, statusDuration, statusStrength)
		act.target = resolve_target(_target)
		act.owner = owner;
		consume(act)
	}
	
	
	static wait = function(duration) {
		consume(new WaitItem(duration))
	}
	
	static particle = function(_target, sprite) {
		
	}


}