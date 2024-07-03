
///Base Class for all enemy moves
function EnemyMove() : CombatInterface() constructor {
	
	providers = []
	actions = []
	
	intent = INTENT.MISC;
	intent_value = undefined;
	
	timeline_entry = new TimelineEnemyMove(self);
	
	static clone = function() {
		var _o = owner;
		//owner = noone;
		var copy = variable_clone(self);
		//owner = _o;
		//copy.owner = _o;
		return copy;
	}
	
	static set_intent = function(_intent, _value = undefined) {
		intent = _intent;
		intent_value = _value;
	}
	
	///Runs when the enemy picks this move at the start of player turn
	static on_move_decided = function() {
		for(var i = 0; i < array_length(providers); i++) {
			providers[i].on_move_decided()
		}
	}
	
	static accept_provider = function(provider) {
		array_push(providers, provider)
		return provider;
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
	static hit = function(damage) {
		return attack(TARGETS.PLAYER, damage)
	}
	
	/// Shorthand for getting a damage provider from input
	static as_damage = function(value, target = TARGETS.PLAYER) {
		return accept_provider(new DamageProvider(value, owner, target))
	}
	
	/// Shorthand for applying freeze to the player
	static freeze = function(value) {
		return apply_status(TARGETS.PLAYER, "Freeze", value)
	}
}