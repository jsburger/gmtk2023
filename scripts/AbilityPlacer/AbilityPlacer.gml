
// Dont make a million of these, I still need to add a prototype system. Like the technical kind of prototype.
register_ability("PlaceBomb", function() {
	with new AbilityPlacer(obj_bomb) {
		name = "Bomb Placer"
		desc = "Place a Bomb"
		sprite_index = spr_bomb
		set_costs(12, 4, 0)
		return self
	}
})

register_ability("PlaceBlock", function() {
	with new AbilityPlacer(obj_block) {
		name = "Block Placer"
		desc = "Place a Block"
		sprite_index = spr_handblock
		set_cost(MANA.BLUE, 1)		
		return self
	}
})
register_ability("PlaceSquirrel", function() {
	with new AbilityPlacer(obj_squirrel_brick) {
		name = "Squirrel Placer"
		desc = "Place Gay Little Squirrel"
		sprite_index = spr_gay_little_squirrel
		set_cost(MANA.RED, 0)		
		return self
	}
})

/// @param {Asset.GMObject} obj
function AbilityPlacer(obj) : Ability(TARGET_TYPE.BOARD) constructor {
	object = obj
	
	static accepts_target = function(target_info) {
		//Call original function
		if __accepts_target(target_info) {
			return board_can_fit(object, mouse_x, mouse_y)
		}
	}
	
	static draw_target = function(origin_x, origin_y, target_info) {
		if accepts_target(target_info) {
			draw_object_ghost(object, mouse_x, mouse_y, c_green)
		}
		else draw_object_ghost(object, mouse_x, mouse_y, c_red)
	}
	
	static act = function() {
		board_place(object, mouse_x, mouse_y)
	}
}

function draw_object_ghost(object, _x, _y, color) {
	var sprite = object_get_sprite(object),
		pos = board_placement_position(object, _x, _y);
	draw_sprite_ext(sprite, sprite_get_animation_frame(sprite), pos.x, pos.y, 1, 1, 0, color, .5)
}