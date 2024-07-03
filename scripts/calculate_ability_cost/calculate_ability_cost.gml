/// @param {Struct.Ability} ability
function calculate_ability_cost(ability) {
	var modifier = new AbilityCostModifier(ability),
		sources = gather_ability_cost_modifiers();
	
	for (var i = 0, l = array_length(sources); i < l; i++) {
		sources[i].modify_ability_cost(modifier);
	}
	
	return modifier.get_result();
}

/// @ignore
function gather_ability_cost_modifiers() {
	var modifiers = [];
	
	var player_statuses;
	with PlayerBattler {
		array_transfer(modifiers, statuses.filter(function(status) {
			return struct_exists(status, "modify_ability_cost")
		}))
	}
	
	return modifiers;
}


/// @ignore
function AbilityCostModifier(ability) constructor {
	self.ability = ability;
	adders = array_create_2d(MANA.MAX);
	multipliers = array_create_2d(MANA.MAX);
	
	static add = function(color, count) {
		array_push(adders[color], count)
	}
	
	static multiply = function(color, count) {
		array_push(multipliers[color], count)
	}
	
	static get_result = function() {
		var original = variable_clone(ability.costs);
		
		for (var i = 0; i < array_length(adders); i++) {
			if original[i] > 0 { //Don't add to 0 costs
				for (var o = 0; o < array_length(adders[i]); o++) {
					original[i] += adders[i][o];
				}
			}
		}
		
		for (var i = 0; i < array_length(multipliers); i++) {
			for (var o = 0; o < array_length(multipliers[i]); o++) {
				original[i] *= multipliers[i][o];
			}
		}
		
		for (var i = 0; i < array_length(original); i++) {
			original[i] = round(original[i])
		}
		
		return original;
		
	}
}