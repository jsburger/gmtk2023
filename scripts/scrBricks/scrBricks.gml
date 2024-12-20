enum SORTING {
	BEFORE = -1,
	EQUAL = 0,
	AFTER = 1
}

#macro __BRICK_RECOLOR_DELAY 3

/// Recolors X bricks to color, preferring uncolored and differently colored bricks.
/// @returns {Real} Amount of bricks recolored
function bricks_recolor(count, _color, sorter = undefined) {
	static finder = new InstanceFinder(parBoardObject) 
		.filter(function(inst, col) {return inst.colorable && inst.color != col})
		.prefer(function(inst) {return inst.color == COLORS.NONE})
	
	
	finder.push(sorter, color)
	var selected = finder.get(count);
	
	//Color the bricks
	for (var i = 0; i < array_length(selected); i++) {
		var change = method({color : _color, inst: selected[i]}, function() {
			inst.set_color(color);
			// Play Sound
			sound_play_random(sound_pool(sndColor1));
			with inst {
				with (instance_create_layer(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), "FX", obj_fx)) {
					sprite_index = sprFXSplat
		
					var rand_scale = random_range(0.5, 1.5);
					image_xscale = rand_scale;
					image_yscale = rand_scale;
					image_blend = mana_get_color(other.color);
				}
			}
		});
		// Todo: move this to combat runner queue
		schedule((__BRICK_RECOLOR_DELAY * i) + 1, change)
	}
	return array_length(selected)
	
}

/// Returns a function which filters instances for that color
function colorable_filter(color) {
	static filters = memoize_array(COLORS.MAX + 1, function(i) {
		return method({col: i - 1}, function(inst) {
			return inst.colorable && inst.color != col;
		})
	});
	return filters[color + 1];
}

function bricks_with_color(color) {
	var n = 0;
	with parBoardObject if colorable && self.color == color n++;
	return n
}

function brick_status_clear(brick) {
	with brick {
		if is_frozen {
			// Clean off frozen without reducing freeze;
			set_frozen(false, true)
		}
		if is_burning {
			set_burning(false);
		}
		if is_poisoned {
			
			set_poisoned(false, true)
		}
	}
}

#region Statuses
	/// Returns if the brick is burning, frozen, or poisoned
	function brick_has_elemental_status(brick) {
		return brick.is_burning || brick.is_frozen || brick.is_poisoned;
	}
	
	
	#region Burn
		function brick_can_burn(brick) {
			return !brick.status_immune && brick.can_burn && !brick_has_elemental_status(brick);
		}

		function bricks_burn(count) {
			static finder = new InstanceFinder(parBoardObject).filter(brick_can_burn);
			// Play Sound
			sound_play_pitch(sndApplyBurn, random_range(.9, 1.01));	
		
			var burnable = finder.get(count);
	
			for (var i = 0; i < array_length(burnable); i++) {
				burnable[i].set_burning(true);
				with (instance_create_layer(burnable[i].x,burnable[i].y, "FX", obj_fx)) {
					sprite_index = sprFXPuffSmall
					image_blend = c_orange
				}			
			}
		}
	#endregion

	#region Freeze
		function brick_can_freeze(brick) {
			return !brick.status_immune && brick.can_freeze && !brick_has_elemental_status(brick);
		}

		function brick_on_unfreeze(brick) {
			with PlayerBattler {
				with statuses.find(STATUS.FREEZE) knock()
			}
		}
	#endregion
	
	#region Poison
		function brick_can_poison(brick) {
			return !brick.status_immune && brick.can_poison && !brick_has_elemental_status(brick);
		}
	
		function brick_lose_poison(brick) {
			with PlayerBattler {
				with statuses.find(STATUS.POISON) knock();
			}
		}
	
	#endregion
	
	#region Curse
		function brick_can_curse(brick) {
			return !brick.status_immune && brick.can_curse && !brick.is_cursed;
		}
		
		function bricks_curse(count) {
			static finder = new InstanceFinder(parBoardObject).filter(brick_can_curse);
			
			array_foreach(finder.get(count), function(inst) {inst.set_cursed(true)})
		}
	#endregion
#endregion

/// Damages a brick.
/// Returns if the brick was actually damaged
function brick_hit(brick, damage, source) {
	if damage <= 0 return false;
	if brick.is_frozen {
		brick.set_frozen(false)
		return false;
	}
	if brick.can_take_damage {
		//Hit brick
		brick.hp -= damage;
		brick.on_hurt(damage, source);
	
		if brick.hp <= 0 {
			
			brick_killed_by_damage(brick)
			
			instance_destroy(brick)
		}
		
		return true;
	}
	return false;
}

/// Run when a board object is destroyed by damage
function brick_killed_by_damage(brick) {
	if brick.is_poisoned {
		//Play sound
		sound_play_pitch(choose(sndGooDeath1, sndGooDeath2, sndGooDeath3), random_range(.9, 1.1));	
		
		with (instance_create_layer(brick.x, brick.y, "FX", obj_fx)) {
			sprite_index = sprFXSplat
		
			var rand_scale = random_range(0.5, 1.5);
			image_xscale = rand_scale;
			image_yscale = rand_scale;
			image_blend = mana_get_color(brick.color);
		}	
	
		
		brick.set_poisoned(false)
	}
}

function board_column_max() {
	return ceil((board_right - board_left)/(2 * TILE_MIN)) - 2;
}
function board_column_random() {
	return irandom(board_column_max())
}

function place_trash_bricks(column, object = BrickNormal, offset = 0) {
	var _x = board_left + TILE_MIN + (2 * TILE_MIN * column) + offset * TILE_MIN,
		_y = board_top + (2 * TILE_MIN);
		
	var collision = collision_rectangle(_x, _y, _x + (2 * TILE_MIN), board_bottom, parBoardObject, false, false);
	if !instance_exists(collision) exit;
	
	var list = ds_list_create();
	var found = false,
		_xright = _x + (2 * TILE_MIN) - 2,
		can_place = false;
	while _y < board_bottom {
		var count = collision_rectangle_list(_x, _y, _xright, _y + TILE_MIN - 1, parBoardObject, true, false, list, false);
		found = false;
		for (var i = 0; i < count; i++) {
			var entry = list[| i];
			if entry.can_collide {
				found = true;
				break;
			}
		}
		if can_place == false {
			if found {
				found = false;
			}
			else {
				can_place = true;
			}
		}
		ds_list_clear(list);
		if found break;
		_y += TILE_MIN;
	}
	ds_list_destroy(list);
	
	var placement = board_placement_position(object, _x, _y - TILE_MIN);
	if found && can_place {
		instance_create_layer(_x, _y - TILE_MIN, "FX", effectDropTrail)
		with instance_create_layer(placement.x, placement.y, "Instances", object) {
			//alarm[0] = x/32
		}
	}
}