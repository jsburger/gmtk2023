enum TARGETS {
	PLAYER,
	NOONE,
	AIMED,
	ABOVE,
	BELOW,
	RANDOM,
	SELF
}

function get_item_target(targetType) {
	with CombatRunner {
		switch(targetType) {
			case TARGETS.PLAYER:
				return player;
			case TARGETS.NOONE:
				return noone;
			case TARGETS.AIMED:
				if is_player_turn return enemies[targeted_enemy];
				return player
			case TARGETS.ABOVE:
				if is_player_turn {
					if targeted_enemy != 0 
						return enemies[targeted_enemy - 1]
					return noone
				}
				if current_enemy != 0 {
					return enemies[current_enemy - 1]
				}
				return noone
			case TARGETS.BELOW:
				if is_player_turn {
					if targeted_enemy != (array_length(enemies) - 1) 
						return enemies[targeted_enemy + 1]
					return noone
				}
				if current_enemy != (array_length(enemies) - 1) {
					return enemies[current_enemy + 1]
				}
				return noone
			case TARGETS.RANDOM:
				if is_player_turn {
					return enemies[irandom(array_length(enemies) - 1)]
				}
				return player
			case TARGETS.SELF:
				if is_player_turn return player
				return enemies[current_enemy]
		}
	}
	return targetType
}

function CombatItem() constructor {
	delay = 0;
	target = noone;
	
	static act = function(runner) {
		
	}
}

function AttackItem(Damage) : CombatItem() constructor {
	delay = 15
	damage = Damage
	
	static act = function(runner) {
		target.hurt(damage)
	}
}

function WaitItem(duration) : CombatItem() constructor {
	delay = duration;
}

function StatusItem(_statusType, _duration, _power) : CombatItem() constructor {
	delay = 15
	status = _statusType
	duration = _duration
	powah = _power
	
	act = function(runner) {
		target.statuses.add(new status(duration, powah))
	}	
}

function attack(_target, damage, times = 1, useStrength = true) {
	if useStrength && instance_exists(self) {
		damage += statuses.get_attack_bonus()		
	}
	with CombatRunner {
		repeat(times) {
			var act = new AttackItem(damage)
			act.target = get_Item_target(_target)
			enqueue(act)
		}
	}
}

function apply(_target, statusType, statusDuration = 1, statusStrength = 1) {
	with CombatRunner {
		var act = new StatusItem(statusType, statusDuration, statusStrength)
		act.target = get_Item_target(_target)
		enqueue(act)
	}
}

function wait(duration) {
	with CombatRunner {
		enqueue(new WaitItem(duration))
	}
}