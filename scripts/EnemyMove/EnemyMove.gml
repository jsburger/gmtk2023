
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
	
	/// @func set_intent
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
	
	/// @func accept_provider
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
	
	/// @func hit
	/// Shorthand for targeting the player with an attack
	static hit = function(damage) {
		return attack(TARGETS.PLAYER, damage)
	}
	
	/// @func as_damage
	/// Shorthand for getting a damage provider from input
	static as_damage = function(value, target = TARGETS.PLAYER) {
		return accept_provider(new DamageProvider(value, owner, target))
	}
	
	/// Shorthand for applying freeze to the player
	static freeze = function(value) {
		return apply_status(TARGETS.PLAYER, STATUS.FREEZE, value)
	}
	
	/// Shorthand for applying poison to the player
	static poison = function(value) {
		return apply_status(TARGETS.PLAYER, STATUS.POISON, value)
	}
	
	/// Shorthand for applying strength to self
	static buff_strength = function(value) {
		return apply_status(TARGETS.SELF, STATUS.STRENGTH, value)
	}
	
	static burn = function(value) {
		var func = method({value}, function() {
				bricks_burn(value)
			}),
			item = run(func);
		item.delay = 15;
		return item;
	}
}