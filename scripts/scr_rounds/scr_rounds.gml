
global.round = 0

#macro BUY_IN 1000
#macro game_speed game_get_speed(gamespeed_fps)


function on_encounter_start(func) {
	static resetCalls = [];
	
	array_push(resetCalls, func)
}

function encounter_start() {
	
	if global.encounter_current == undefined {
		global.encounter_current = encounter_get()
	}
	
	array_foreach(on_encounter_start.resetCalls, function(call) {
		call()
	})
	
	global.round = 0
	with CombatRunner combat_started = true;	
	
	var encounter = global.encounter_current;
	
	array_foreach(encounter.enemies, function(entry, index) {
		with CombatRunner {
			with add_enemy(entry) {
				visible = false
				schedule(15 * (index + 1), function() {
					visible = true;
					with instance_create_depth(x, y, depth - 1, obj_brick_flash) {
						sprite_index = other.sprite_index
						image_index = other.image_index
						image_speed = other.image_speed
					}
				})
			}
		}
	})
	
	start_new_level()
	schedule(10, function() {round_start()})
}

function round_start() {
	with par_bricklike event_perform(ev_other, ev_user15);
	with obj_ball event_perform(ev_other, ev_user15);
	
	
	with EnemyBattler {
		decide_actions()
	}
	
	schedule(10, function() {player_turn_start()})
}

function player_turn_start() {
	with CombatRunner is_player_turn = true
	CombatRunner.throws = 1
	
	if CombatRunner.throws > 0 {
		schedule(40, enable_shooter)
	}
}

function enable_shooter() {
	with obj_shooter {
		has_dice = true
		can_shoot = true
		sprite_index = spr_hand_idle_a;
	}
}

function throw_start(){
	CombatRunner.throws -= 1;
	if instance_exists(obj_ballplacer) with obj_ballplacer instance_destroy();
	if instance_exists(obj_ball) with obj_ball canmove = true;
	
	
	//Reset gained mana
	for (var i = 0; i < MANA.MAX; ++i) {
		global.mana_gained[i] = 0;
	}	
}

function throw_end() {
	with obj_shooter can_shoot = false;
	if global.mana_gained[MANA.RED] > 0 {
		schedule(15, function() {
			CombatRunner.mount_ability(new AbilityAttack(global.mana_gained[MANA.RED]).dont_cancel(),
			function() {
				CombatRunner.enqueue(new FunctionItem(throw_resolve))
			})
		})
	}
	else {
		CombatRunner.enqueue(new FunctionItem(throw_resolve))
	}
	if global.mana_gained[MANA.BLUE] > 0 {
		with PlayerBattler block += global.mana_gained[MANA.BLUE]
	}
}

function throw_resolve() {
	if check_fullclear() {
		say_line(sound_pool("vo_fullclear"))
		make_new_board()
		CombatRunner.throws++
	}
	
	if CombatRunner.throws > 0 {
		schedule(15, enable_shooter)
	}
}

function player_turn_end() {
	
	if combat_active() {
		with CombatRunner {
			is_player_turn = false;
			waitTime += 10;
		}
	}
	//schedule(10, enemy_turn)
	enemy_turn()
}

function enemy_turn() {
	//with CombatRunner is_player_turn = false
}

function round_end() {
	global.round += 1;
	if global.round mod current_level.info.rounds == 0 {
		make_new_board()
	}
	if !obj_board.editor schedule(30, function() {round_start()})
}


function check_fullclear() {
	var fullclear = true;
		with obj_block {
			if is_destructible {
				fullclear = false
				break
			}
		}
		with obj_vault {
			if !unloaded {
				fullclear = false
				break
			}
		}
	return fullclear;
}

/// Destroys current board and spawns a new one shortly after
function make_new_board() {
	with obj_stain_effect{
		clear_item()	
	}
	with par_bricklike {
		clear_item()
	}
	with par_collectible {
		clear_item()
	}
	with obj_ball {
		clear_item()
	}
	schedule(8, start_new_level)
	
}

function clear_item() {
	with instance_create_depth(x, y, depth - 1, obj_brick_flash) {
		sprite_index = other.sprite_index
		image_index = other.image_index
		image_speed = 0
	}
	instance_destroy(self, false);
}

function start_new_level() {
	
	global.round = 0;
	
	var encounter = global.encounter_current;
	var i = 0;
	if encounter != undefined {
		var board = encounter.get_board();
		i = level_id_by_name(board);
	}
	level_load(i)
	say_line(sound_pool("vo_startboard"), -1, false);

}