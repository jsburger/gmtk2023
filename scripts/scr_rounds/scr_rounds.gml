
#macro BUY_IN 1000
#macro game_speed game_get_speed(gamespeed_fps)


function encounter_start() {
	start_new_level()
	schedule(10, function() {round_start()})
}

function round_start() {
	if instance_exists(par_bricklike) with par_bricklike event_perform(ev_other, ev_user15);
	if instance_exists(obj_ball) with obj_ball event_perform(ev_other, ev_user15);
	
	
	with EnemyBattler {
		bump_action()
	}
	
	schedule(10, function() {player_turn_start()})
}

function player_turn_start() {
	with CombatRunner is_player_turn = true
	schedule(40, function() {
		with obj_shooter {
			has_dice = true
			can_shoot = true
			sprite_index = spr_hand_idle_a;
		}
	})
}

function throw_start(){
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
			CombatRunner.mount_ability(new AbilityAttack(global.mana_gained[MANA.RED]))
		})
	}
	if global.mana_gained[MANA.BLUE] > 0 {
		with PlayerBattler block += global.mana_gained[MANA.BLUE]
	}
	
}

function player_turn_end() {
	
	schedule(10, enemy_turn)
}

function enemy_turn() {
	with CombatRunner is_player_turn = false
}

function round_end() {
	global.rounds += 1;
	global.round += 1;
	if global.round mod 5 == 0 {
		global.round = 0
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
	if global.wasUsingEditor {
		level_load_ext(global.level_num)
	}
	else {
		var i = global.levels[| 0];
		level_load_ext(i)
		say_line(choose(vo_startboard01, vo_startboard02, vo_startboard03, vo_startboard04, vo_startboard05, vo_startboard06, vo_startboard07, vo_startboard08, vo_startboard09, vo_startboard10), -1, false);
		ds_list_delete(global.levels, 0)
	}
}