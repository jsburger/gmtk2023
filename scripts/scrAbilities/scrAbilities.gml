
enum TARGET_TYPE {
	NONE,
	BOARD,
	BATTLER
}


function register_ability(name, abilityFactory) {
	static abilities = ds_map_create();
	ds_map_add(abilities, name, abilityFactory)
}
/// @returns {Id.DsMap<Function>}
function ability_get_register() {
	// Feather disable once GM1045
	return register_ability.abilities;
}

function ability_get_prototype(name) {
	return ability_get_register()[? name]
}
function ability_get(name) {
	var proto = ability_get_prototype(name);
	return proto();
}


function Ability(TargetType = TARGET_TYPE.BATTLER) : CombatInterface() constructor {
	
	needs_target = false
	if TargetType != TARGET_TYPE.NONE {
		needs_target = true
	}
	target_type = TargetType
	costs = array_create(MANA.MAX);
	
	name = "Ability"
	desc = "Description"
	sprite_index = sprChip
	image_xscale = 1
	image_yscale = 1
	
	use_max = infinity;
	uses = use_max;
	
	can_cancel = true;
	
	modified_costs = new FrameCache(function() {
		return calculate_ability_cost(self);
	})
	
	position = 0;
	
	static act = function() {}
	
	/// Resets variables. Called on player turn start
	static reset = function() {
		uses = use_max;
	}
	
	static set_cost = function(type, amount) {
		costs[type] = amount
	}
	static set_costs = function(red = 0, blue = 0, yellow = 0) {
		costs[MANA.RED] = red
		costs[MANA.BLUE] = blue
		costs[MANA.YELLOW] = yellow
	}
	
	static set_uses = function(n) {
		uses = n;
		use_max = n;
	}
	
	static can_cast = function() {
		if uses <= 0 return false;
		var costs = modified_costs.get();
		for (var i = 0; i < MANA.MAX; ++i) {
		    if global.mana[i] < costs[i] return false
		}
		return true
	}
	
	static spend_mana = function() {
		var costs = modified_costs.get();
		for (var i = 0; i < MANA.MAX; ++i) {
		    global.mana[i] -= costs[i]
		}
	}
	
	/// Where mana is spent and uses are decremented.
	static after_cast = function() {
		if uses > 0 {
			uses -= 1;
		}
		spend_mana();
	}
	
	#region Targeting logic:
		static set_targets = function(target_type) {
			self.target_type = target_type
			if target_type != TARGET_TYPE.NONE {
				needs_target = true
			}
			else {
				needs_target = false	
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
	
	static dont_cancel = function() {
		can_cancel = false;
		return self
	}
	
}

function AbilityAttack(Damage) : Ability() constructor {
	damage = Damage
	
	static act = function() {
		attack(TARGETS.AIMED, damage)
	}
	
	static draw_target = function(origin_x, origin_y, hovered_target) {
		draw_line_width_color(origin_x, origin_y, mouse_x, mouse_y, 3, c_white, c_red)
		var _x = mouse_x, _y = mouse_y
		if (accepts_target(hovered_target)) {
			_x = hovered_target.instance.x;
			_y = hovered_target.instance.bbox_top + 24
			draw_sprite_auto(sprAttackTarget, hovered_target.instance.x, hovered_target.instance.y)
		}
		font_push(fntBig, fa_center, fa_bottom)
		draw_text_transformed(_x, _y, -damage, 1.5, 1.5, 0)
		font_pop()
	}
}

function AbilityDefend(Block) : Ability() constructor {
	block = Block
	set_targets(TARGET_TYPE.NONE)
	
	static act = function() {
		defend(TARGETS.SELF, block)
	}	
}

/// @param {Function} func
function FunctionAbility(func) : Ability() constructor {
	callback = func
	
	static act = function() {
		callback()
	}
}