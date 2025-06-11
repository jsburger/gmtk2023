enum SORTING {
	BEFORE = -1,
	EQUAL = 0,
	AFTER = 1
}

/// Recolor a single brick
function brick_recolor(brick, _color) {
	with brick {
		set_color(_color);
		sound_play_random(sound_pool(sndColor1));
		with instance_create_layer(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), "FX", obj_fx) {
			sprite_index = sprFXSplat
		
			var rand_scale = random_range(0.5, 1.5);
			image_xscale = rand_scale;
			image_yscale = rand_scale;
			image_blend = mana_get_color(_color);
		}
	}
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
		if is_cursed {
			set_cursed(false);
		}
	}
}

function brick_status_text(brick) {
	var a = [];
	if brick.is_burning {
		array_push(a,
			"Burning:",
			"Hitting this brick with your ball will inflict you with 1 stack of Burn.",
			"Burn deals damage to you when casting spells."
		);
	}
	if brick.is_frozen {
		array_push(a,
			"Frozen:",
			"While this brick is frozen, your spells cost more.",
			"Dealing damage to this brick will instead un-freeze it."
		);
	}
	if brick.is_poisoned {
		array_push(a,
			"Poisoned:",
			"At the end of your turn, take 1 damage.",
		);
	}
	if brick.is_cursed {
		array_push(a,
			"Cursed:",
			"When destroyed, this will fire a projectile at the Shooter."
		)
	}
	return a;
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
	
	array_push(global.dead_bricks, jsonify_instance(brick));
}

function board_column_max() {
	return ceil((board_right - board_left)/(2 * TILE_MIN)) - 2;
}
function board_column_random() {
	return irandom(board_column_max())
}

function place_trash_bricks(column, object = BrickNormal, offset = 0) {
	var width = object_width(object),
		height = object_height(object);
	var _x = board_left + TILE_MIN + (width * column) + offset * TILE_MIN,
		_y = board_top + (TILE_MIN + height);
		
	var collision = collision_rectangle(_x, _y, _x + (width), board_bottom, parBoardObject, false, false);
	if !instance_exists(collision) exit;
	
	var list = ds_list_create();
	var found = false,
		_xright = _x + (width),
		can_place = false;
	while _y < board_bottom {
		var count = collision_rectangle_list(_x, _y, _xright, _y + height, parBoardObject, true, false, list, false);
		found = false;
		for (var i = 0; i < count; i++) {
			var entry = list[| i];
			if entry.can_collide || instance_is(entry, FakeSolid) {
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
	
	var placement = board_placement_position(object, _x, _y - TILE_MIN, ALIGNMENT.LOWER, ALIGNMENT.LOWER);
	if found && can_place {
		instance_create_layer(_x, _y - height, "FX", effectDropTrail)
		with instance_create_layer(placement.x, placement.y, "Instances", object) {
			//alarm[0] = x/32
			return self;
		}
	}
}