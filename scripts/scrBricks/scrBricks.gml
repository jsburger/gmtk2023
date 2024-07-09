#macro __BRICK_RECOLOR_DELAY 3

/// Recolors X bricks to color, preferring uncolored and differently colored bricks.
/// @returns {Real} Amount of bricks recolored
function bricks_recolor(count, _color) {
	var colorable = array_build_filtered(obj_block, function(brick) {
			return var_defget(brick, "colorable", false)
		}),
		colorless = array_filter(colorable, function(brick) {
			return brick.color == MANA_NONE;
		});
		
	//Build array of bricks to color
	var selected = [];
	if array_length(colorless) <= count || (_color == MANA_NONE) {
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
				var shuffled = array_shuffle(different_colors);
				repeat dif {
					array_push(selected, array_pop(different_colors))
				}
			}
		}
	}
	// More colorless bricks than count
	else {
		var shuffled = array_shuffle(colorless);
		repeat count {
			array_push(selected, array_pop(shuffled))
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


function brick_on_unfreeze(brick) {
	with PlayerBattler {
		with statuses.find("Freeze") knock()
	}
}
