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
	
	myscript = undefined
	
	static set_attack = function(dmg, times = 1, useStrength = true) {
		attackdamage = dmg;
		attacktimes = times;
		attackusesStrength = useStrength;
		
		if !array_contains(intent, INTENT.ATTACK) {
			array_push(intent, INTENT.ATTACK)
		}
		
		return self
	}
	
	static run = function(callback) {
		myscript = callback
		
		return self
	}
	
	static execute = function() {
		if attacktimes != 0 && attackdamage > 0 {
			attack(TARGETS.PLAYER, attackdamage, attacktimes, attackusesStrength)
		}
		myscript()
	}
	
}