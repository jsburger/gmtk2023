
///Base Class for all enemy moves
function EnemyMove() : CombatInterface() constructor {
	
	providers = []
	actions = []
	
	
	///Runs when the enemy picks this move at the start of player turn
	static on_move_decided = function() { }
	
	static accept_provider = function(provider) {
		array_push(providers, provider)
	}
	
	/// @param {Struct.CombatItem} item
	static consume = function(item) {
		array_push(actions, item)
	}
	
	static act = function() {
		array_foreach(actions, function(action) {
			with CombatRunner enqueue(action)
		})
	}
	
	/// Shorthand for targeting the player with an attack
	static hit = function(damage, useStrength = true) {
		attack(TARGETS.PLAYER, damage, useStrength)
	}
	
	
}

function Provider(_value) constructor {
	
	value = _value
	
	static get = function() {
		return value;
	}
	
	static on_move_decided = function() {}
}

function RangeProvider(minValue, maxValue) : Provider(minValue) constructor {
	min_value = minValue
	max_value = maxValue
	
	static on_move_decided = function() {
		value = irandom_range(min_value, max_value)
	}
}


