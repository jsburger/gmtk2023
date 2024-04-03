
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


