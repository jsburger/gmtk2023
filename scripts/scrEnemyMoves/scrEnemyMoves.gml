enum INTENT {
	ATTACK,
	BLOCK,
	DEBUFF,
	MISC
}


function Action() constructor {
	intent = []
	
	attackdamage = 0;
	attacktimes = 0;
	attackusesStrength = false;
	
	myscript = undefined;
	
	owner = noone;
	
	static set_attack = function(dmg, times = 1, useStrength = true) {
		attackdamage = dmg;
		attacktimes = times;
		attackusesStrength = useStrength;
		
		add_intents(INTENT.ATTACK)
		
		return self
	}
	
	static add_intents = function() {
		for (var i = 0; i < argument_count; ++i) {
			if !array_contains(intent, argument[i]) {
				array_push(intent, argument[i])
			}
		}
	}
	
	static run = function(callback) {
		myscript = method(owner, callback)
		
		return self
	}
	
	static execute = function() {
		if instance_exists(owner) CombatRunner.current_actor = owner;
		if attacktimes != 0 && attackdamage > 0 {
			attack(TARGETS.PLAYER, attackdamage, attacktimes, attackusesStrength)
		}
		myscript()
	}
	
}