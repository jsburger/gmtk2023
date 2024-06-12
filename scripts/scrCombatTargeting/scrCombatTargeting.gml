enum TARGETS {
	PLAYER,
	NOONE,
	AIMED,
	ABOVE,
	BELOW,
	RANDOM,
	SELF,
	
	MAX
}

function get_item_target(targetType) {
	with CombatRunner {
		switch(targetType) {
			case TARGETS.PLAYER:
				return player;
			case TARGETS.NOONE:
				return noone;
			case TARGETS.AIMED:
				if is_player_turn return current_target;
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

function get_current_actor() {
	if instance_exists(self) && instance_is(self, Battler) return self;
	with CombatRunner {
		if is_player_turn with PlayerBattler return self
		if instance_exists(current_actor) return current_actor
	}
	return noone;
}

