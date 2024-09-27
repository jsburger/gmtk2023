enum TARGETS {
	PLAYER,
	NOONE,
	AIMED,
	RANDOM_OTHER_ENEMY,
	RANDOM_ENEMY,
	SELF,
	//Multi targets
	ALL,
	NOT_ME,
	OTHER_ENEMIES,
	ALL_ENEMIES,
	
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
			case TARGETS.SELF:
				if is_player_turn return player
				return enemies[current_enemy];
			case TARGETS.RANDOM_ENEMY:
				return enemies[irandom(array_length(enemies) - 1)];
			case TARGETS.RANDOM_OTHER_ENEMY:
				return array_random_excluding(enemies, current_enemy);
			case TARGETS.ALL:
				var c = [player];
				array_copy(c, 1, enemies, 0, array_length(enemies));
				return c;
			case TARGETS.NOT_ME:
				if is_player_turn {
					return array_clone_shallow(enemies);
				}
				var a = [player];
				for (var i = 0; i < array_length(enemies); i++) {
					if i != current_enemy {
						array_push(a, enemies[i])
					}
				}
				return a;
			case TARGETS.OTHER_ENEMIES:
				var a = [];
				for (var i = 0; i < array_length(enemies); i++) {
					if i != current_enemy {
						array_push(a, enemies[i])
					}
				}
				return a;
			case TARGETS.ALL_ENEMIES:
				return array_clone_shallow(enemies)
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

