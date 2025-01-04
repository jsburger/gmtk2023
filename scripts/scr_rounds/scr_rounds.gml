
global.round = 0

// Fuck it why not
global.interface = new CombatInterface();

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
	
	//var array = array_build(AbilityButton);
	//array_sort(array, function(a, b) {if a.y > b.y return 1 else return -1})
	//array_foreach(array, function(inst, index) {inst.ability.position = index})
	
	
	
	
	global.round = 0
	with CombatRunner combat_started = true;	
	
	var encounter = global.encounter_current;
	for (var i = 0; i < array_length(encounter.enemies); i++) {
		var entry = encounter.enemies[i];
		with CombatRunner {
			with add_enemy(entry) {
				visible = false
				schedule(15 * (i + 1), function() {
					visible = true;
					with instance_create_depth(x, y, depth - 1, obj_brick_flash) {
						sprite_index = other.sprite_index
						image_index = other.image_index
						image_speed = other.image_speed
					}
				})
			}
		}
	}
	
	start_new_board()
	schedule(10, function() {round_start()})
}

function round_start() {
	static interface = new CombatInterface();
	
	with par_bricklike event_perform(ev_other, ev_user15);
	
	
	with EnemyBattler {
		decide_actions()
	}
	
	with parBoardObject if on_round_start != undefined {
		on_round_start();
	}
	
	interface.wait(10);
	interface.run(player_turn_start)
}

function player_turn_start() {
	static interface = new CombatInterface();
	
	CombatRunner.is_player_turn = true
	CombatRunner.throws = 1
	PlayerBattler.turn_start()
	
	
	if CombatRunner.throws > 0 {
		interface.wait(20)
		interface.run(enable_shooter)
	}
}

function enable_shooter() {
	
	mana_add(MANA.YELLOW, 3)
	with Shooter {
		mana_effect_create(x, y, MANA.YELLOW, 3)
	}
	
	with Shooter {
		has_dice = true
		can_shoot = true
		sprite_index = sprHandIdleA;
	}
	
	
}

function throw_start(){
	
	with SafetyNet activate();
	CombatRunner.throws -= 1;
	if instance_exists(obj_ballplacer) with obj_ballplacer instance_destroy();
	
	
	//Reset gained mana
	for (var i = 0; i < MANA.MAX; ++i) {
		global.mana_gained[i] = 0;
	}	
}

function throw_end() {
	with Shooter can_shoot = false;
	
	var enders = array_build_filtered(parBoardObject, function(i) {return i.on_throw_end != undefined});
	array_sort(enders, sort_y)
	for (var i = 0; i < array_length(enders); i++) {
		enders[i].on_throw_end()
	}
	
	if global.mana_gained[MANA.RED] > 0 {
		schedule(15, function() {
			var ability = new AbilityAttack(global.mana_gained[MANA.RED]).dont_cancel();
				ability.is_normal_ass_attack = true;
			CombatRunner.mount_ability(ability,
			function() {
				CombatRunner.enqueue(new FunctionItem(noone, throw_resolve))
			})
		})
	}
	else {
		CombatRunner.enqueue(new FunctionItem(noone, throw_resolve))
	}
	if global.mana_gained[MANA.BLUE] > 0 {
		with PlayerBattler block += global.mana_gained[MANA.BLUE]
	}
}

function throw_resolve() {
	if check_fullclear() {
		say_line(sound_pool("voFullClear"))
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
			player.turn_end();
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
	if global.round mod board_rounds() == 0 {
		make_new_board()
	}
	if !Board.editor schedule(30, function() {round_start()})
}

function board_rounds() {
	return current_level.info.rounds;
}

function board_is_last_round() {
	return global.round == (board_rounds() - 1);
}

function check_fullclear() {
	var fullclear = true;
		with obj_block {
			if is_destructible {
				fullclear = false
				break
			}
		}
		with parBoardObject {
			if (can_take_damage && !fullclear_ignore) || fullclear_forced {
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
	with BoardOccupant clear_item()
	schedule(8, start_new_board)
	
}

function clear_item() {
	with instance_create_depth(x, y, depth - 1, obj_brick_flash) {
		sprite_index = other.sprite_index
		image_index = other.image_index
		image_speed = 0
	}
	instance_destroy(self, false);
}

function start_new_board() {
	
	global.round = 0;
	
	var encounter = global.encounter_current;
	var i = 0;
	if encounter != undefined {
		var board = encounter.get_board();
		i = level_id_by_name(board);
	}
	level_load(i)
	say_line(sound_pool("voBoardStart"), -1, false);
	
	update_battler_bricks()
}

function update_battler_bricks() {
	for (var i = 0; i < array_length(CombatRunner.enemies); i++) {
		var enemy = CombatRunner.enemies[i];
		with BattlerBrick if size == enemy.size && !instance_exists(battler) {
			battler = enemy
			battler.go_to(x, y)
			var mask = mask_index == -1 ? sprite_index : mask_index;
			battler.mask_index = mask;
			battler.spr_frame = sprite_index;
			battler.spr_bg = spr_bg;
			
			break;
		}
	}
}