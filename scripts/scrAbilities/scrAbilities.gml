
enum TARGET_TYPE {
	NONE,
	BOARD,
	BATTLER
}


function register_ability(name, abilityFactory) {
	static abilities = ds_map_create();
	ds_map_add(abilities, name, abilityFactory)
}
function ability_get_register() {
	return register_ability.abilities;
}
function ability_get_prototype(name) {
	return ability_get_register()[? name]
}


function Ability(TargetType = TARGET_TYPE.BATTLER) constructor {
	
	needs_target = false
	if TargetType != TARGET_TYPE.NONE {
		needs_target = true
	}
	target_type = TargetType
	costs = array_create(MANA.MAX);
	
	name = "Ability"
	desc = "Description"
	sprite_index = spr_chip
	
	static act = function() {
		
	}
	
	static set_cost = function(type, amount) {
		costs[type] = amount
	}
	static set_costs = function(red = 0, blue = 0, yellow = 0) {
		costs[MANA.RED] = red
		costs[MANA.BLUE] = blue
		costs[MANA.YELLOW] = yellow
	}
	
	static can_cast = function() {
		for (var i = 0; i < MANA.MAX; ++i) {
		    if global.mana[i] < costs[i] return false
		}
		return true
	}
	
	static spend_mana = function() {
		for (var i = 0; i < MANA.MAX; ++i) {
		    global.mana[i] -= costs[i]
		}
	}
	
	#region Targeting logic:
		static set_targets = function(target_type) {
			self.target_type = target_type
			if target_type != TARGET_TYPE.NONE {
				needs_target = true
			}
		}
	
		static accepts_target = function(target_info) {
			return target_info.type == target_type
		}
		static __accepts_target = accepts_target
		
		static draw_target = function(origin_x, origin_y, hovered_target) {
			draw_line_width_color(origin_x, origin_y, mouse_x, mouse_y, 3, c_white, c_red)
			if (accepts_target(hovered_target)) {
				draw_circle_color(mouse_x, mouse_y, 4, c_red, c_red, false)
			}
		}
		
	#endregion
	
	
}

function BasicAttack(Damage) : Ability() constructor {
	damage = Damage
	
	static act = function() {
		attack(TARGETS.AIMED, damage, 1, true)
	}
}

function RedManaAttack(Damage, Cost) : BasicAttack(Damage) constructor {
	set_cost(MANA.RED, Cost)
	
}

function FunctionAbility(func) : Ability() constructor {
	callback = func
	
	static act = function() {
		callback()
	}
}