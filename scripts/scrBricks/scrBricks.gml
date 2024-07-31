enum SORTING {
	BEFORE = 1,
	EQUAL = 0,
	AFTER = -1
}

#macro __BRICK_RECOLOR_DELAY 3

/// Recolors X bricks to color, preferring uncolored and differently colored bricks.
/// @returns {Real} Amount of bricks recolored
function bricks_recolor(count, _color, sorter = undefined) {
	var colorable = array_build_filtered(parBoardObject, function(brick) {
			return brick.colorable;
		}),
		colorless = array_filter(colorable, function(brick) {
			return brick.color == MANA_NONE;
		});
		
	//Build array of bricks to color
	var selected = [];
	if array_length(colorless) <= count || (_color == MANA_NONE) {
		// Take all colorless bricks available
		if _color != MANA_NONE selected = colorless;
		// Need more bricks, use differently colored ones
		if array_length(selected) < count {
			var filter = method({color : _color}, function(brick) {
					return (brick.color != color) && brick.color != MANA_NONE;
				}),
				different_colors = array_filter(colorable, filter),
				dif = count - array_length(selected);
			
			// If there's not enough bricks, take as many as possible
			if array_length(different_colors) <= dif {
				array_transfer(selected, different_colors)
			}
			// Otherwise, take as many as needed
			else {
				var source;
				if sorter == undefined {
					source = array_shuffle(different_colors);
				}
				else {
					array_sort(different_colors, sorter)
					source = different_colors
				}
				repeat dif {
					array_push(selected, array_pop(source))
				}
			}
		}
	}
	// More colorless bricks than count
	else {
		var source;
		if sorter == undefined {
			source = array_shuffle(colorless);
		}
		else {
			source = colorless
			array_sort(colorless, sorter)
		}
		repeat count {
			array_push(selected, array_pop(source))
		}
	}
	
	
	//Color the bricks
	for (var i = 0; i < array_length(selected); i++) {
		var change = method({color : _color, inst: selected[i]}, function() {
			inst.set_color(color);
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
		
		schedule((__BRICK_RECOLOR_DELAY * i) + 1, change)
	}
	return array_length(selected)
	
}

function bricks_with_color(color) {
	var n = 0;
	with parBoardObject if self.color == color n++;
	return n
}


function brick_on_unfreeze(brick) {
	with PlayerBattler {
		with statuses.find(STATUS.FREEZE) knock()
	}
}

/// Returns if the brick was actually damaged
function brick_hit(brick, damage, source) {
	if brick.is_frozen {
		brick.set_frozen(false)
		return false;
	}
	if brick.can_take_damage {
		//Hit brick
		brick.hp -= damage;
		brick.on_hurt(damage, source);
	
		if brick.hp <= 0 {
			instance_destroy(brick)
		}
		
		return true;
	}
	return false;
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