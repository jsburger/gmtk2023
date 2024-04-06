function CombatInterface() constructor {
	
	owner = noone;
	
	static set_owner = function(source) {
		owner = source;
		return self;
	}
	
	static act = function() {
		
	}
	
	static consume = function(item) {
		CombatRunner.enqueue(item)
	}


	static attack = function(_target, damage, useStrength = true) {
		if useStrength {
			if instance_exists(owner) {
				damage += owner.statuses.get_attack_bonus()
			}
		}
		var act = new AttackItem(damage)
		act.target = _target
		act.owner = owner;
		consume(act)
	}
	
	static defend = function(_target, block) {
		var act = new DefendItem(block)
		act.target = _target
		act.owner = owner;
		consume(act)			
	}
	
	static give_status = function(_target, statusType, statusDuration = 1, statusStrength = 1) {
		var act = new StatusItem(statusType, statusDuration, statusStrength)
		act.target = _target
		act.owner = owner;
		consume(act)
	}
	
	
	static wait = function(duration) {
		consume(new WaitItem(duration))
	}
	
	static effect = function(_target, sprite) {
		
	}


}
