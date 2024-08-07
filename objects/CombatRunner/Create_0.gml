/// @description 

enum PHASES {
	BEGIN,
	TURN,
	END
}


schedule(20, function() {encounter_start()})

actions = [];
resolving_actions = [];
move_queue = [];

is_player_turn = true;
phase = PHASES.BEGIN
phaseProgress = 0
waitForPlayer = false
run_round_end = false;


player = noone;
enemies = [];
current_enemy = 0;
current_actor = noone;
targeted_enemy = 0;

waitTime = 0;
acting = false;

current_ability = undefined;
targeting = false;
post_ability = undefined;

current_target = undefined;

combat_started = false;
combat_ending = false;

throws = 1;

#region Running Ability Logic

	mount_ability = function(ability, call_after = undefined) {
		if current_ability != undefined {
			cancel_targeting()
		}
		current_ability = ability
		targeting = ability.needs_target
		if call_after != undefined {
			post_ability = call_after;
		}		
		if !targeting {
			run_ability()
			//cancel_targeting()
		}
	}

	run_ability = function() {
		//current_actor = PlayerBattler.id;
		current_ability.act();
		current_ability.spend_mana();
		if post_ability != undefined {
			post_ability();
			post_ability = undefined;
		}
		
		if !struct_exists(current_ability, "is_normal_ass_attack") {
			with Battler {
				statuses.on_ability_used();
			}
		}
		current_ability = undefined;
	}
	
	accept_target = function(info) {
		if current_ability.accepts_target(info) {
			current_target = info
			run_ability()
			cancel_targeting() //Doesn't really cancel, just cleans up
		}
	}
	
	cancel_targeting = function() {
		current_ability = undefined;
		targeting = false;
		post_ability = undefined;
		with AbilityButton if active {
			active = false
		}
	}
	
	
	
#endregion

enqueue = function(action) {
	if acting {
		array_push(resolving_actions, action)
	}
	else {
		array_push(actions, action)
	}
}

enqueue_move = function(move) {
	array_push(move_queue, move)
}

has_actions = function() {
	return (array_length(actions) > 0 || array_length(resolving_actions) > 0 || array_length(move_queue) > 0)
}

is_busy = function() {
	return has_actions() || waitTime > 0;
}

do_phase_action = function(target) {
	current_enemy = phaseProgress
	current_actor = target
	if target.canact == false exit
	if phase == PHASES.BEGIN {
		target.turn_start()
	}
	if phase == PHASES.TURN {
		target.turn()
	}
	if phase == PHASES.END {
		target.turn_end()
	}
}

/// Spawn an object and add it as an enemy
add_enemy = function(enemyObj) {
	var inst;
	if is_array(enemyObj) {
		inst = instance_create_layer(1088, 256 + 128 * array_length(enemies), "Instances", enemyObj[0], enemyObj[1])
	}
	else {
		inst = instance_create_layer(1088, 256 + 128 * array_length(enemies), "Instances", enemyObj)
	}
	with inst {
		//if other.combat_started {
		//	battle_start();
		//}
		return other.add_enemy_instance(self)
	}
}
/// Add a created instance to CombatRunner's enemies
add_enemy_instance = function(instance) {
	static colors = [c_red, c_aqua, c_orange, c_lime];
	array_push(enemies, instance)
	instance.enemy_position = array_length(enemies) - 1
	instance.bg_color = colors[instance.enemy_position]
	
	instance.after_create()
	
	obj_board.accept_objects_from(instance)
	
	return instance
}

remove_enemy = function(index) {
	with enemies[index] {
		instance_destroy()
	}
	
	for (var i = index + 1; i < array_length(enemies); i++) {
		enemies[i].enemy_position -= 1
	}
	
	array_delete(enemies, index, 1)
	if phaseProgress >= index phaseProgress -= 1
	
}

/// @self CombatRunner
on_battler_die = function(battler) {
	if instance_is(battler, EnemyBattler) {
		//Remove actions related to this battler.
		var filter = method(battler, function(action) {
			return action.get_target() != self && action.owner != self;
		})
		array_filter_smart(actions, filter);
		array_filter_smart(resolving_actions, filter);
		Timeline.update()
	}
	
	// Check for combat being over;
	var over = true;
	for (var i = 0; i < array_length(enemies); i++) {
		if enemies[i].hp > 0 {
			over = false;
			break;
		}
	}
	if instance_is(battler, PlayerBattler) over = true;
	
	if over {
		end_combat();
	}	
}

end_combat = function() {
	actions = [];
	resolving_actions = [];
	
	combat_ending = true;
	
	fade_to(encounter_room)
	
}