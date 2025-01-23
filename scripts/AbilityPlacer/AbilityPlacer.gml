
// Dont make a million of these, I still need to add a prototype system. Like the technical kind of prototype.
register_ability("PlaceBomb", function() {
	with new AbilityPlacer(Bomb) {
		name = "Bomb Placer"
		desc = "Place a Bomb"
		sprite_index = sprBomb
		set_costs(12, 4, 0)
		return self
	}
})

register_ability("PlaceBlock", function() {
	with new AbilityPlacer(BrickNormal) {
		name = "Block Placer"
		desc = "Place a Block"
		sprite_index = sprBrick
		set_cost(MANA.BLUE, 1)		
		return self
	}
})
register_ability("PlaceBarrel", function() {
	with new AbilityPlacer(Barrel) {
		name = "Barrel Placer"
		desc = "Place a Barrel"
		can_rotate = true;
		rotation = 45;
		sprite_index = sprBarrel
		set_cost(MANA.YELLOW, 2)	
		return self
	}
})
/// @param {Asset.GMObject} obj
function AbilityPlacer(obj) : Ability(TARGET_TYPE.BOARD) constructor {
	object = obj
	rotation = 0;
	can_rotate = false;
	
	static on_target_step = function() {
		if can_rotate {
			var rotate = button_pressed(inputs.turn_right) - button_pressed(inputs.turn_left);
			if rotate != 0 {
				rotation = anglefy(rotation - (rotate * 90));
			}
		}
	}
	
	static accepts_target = function(target_info) {
		//Call original function
		if __accepts_target(target_info) {
			return board_can_fit(object, mouse_x, mouse_y)
		}
	}
	
	static draw_target = function(origin_x, origin_y, target_info) {
		if accepts_target(target_info) {
			draw_object_ghost(object, mouse_x, mouse_y, c_green, rotation)
		}
		else draw_object_ghost(object, mouse_x, mouse_y, c_red, rotation)
	}
	
	static act = function() {
		with board_place(object, mouse_x, mouse_y) {
			if other.can_rotate {
				set_rotation(other.rotation)
			}
		}
		sound_play_pitch(sndDieHitBrick, random_range(1.7, 3));
	}
}

function draw_object_ghost(object, _x, _y, color, rotation = 0) {
	var sprite = object_get_sprite(object),
		pos = board_placement_position(object, _x, _y);
	draw_sprite_ext(sprite, sprite_get_animation_frame(sprite), pos.x, pos.y, 1, 1, rotation, color, .5)
}