
///Base Class for all enemy moves
function EnemyMove(_owner) : CombatInterface() constructor {
	set_owner(_owner)
	
	providers = []
	actions = []
	
	timeline_entry = new TimelineEnemyMove(_owner);
	
	is_rerollable = true;
	
	static clone = function() {
		var _o = owner;
		//owner = noone;
		var copy = variable_clone(self);
		//owner = _o;
		//copy.owner = _o;
		return copy;
	}
	
	/// @func set_intent
	static set_intent = function(intent, value = undefined) {
		with timeline_entry.add_intent(new Intent(intent_get_icon(intent), value)) {
			ref = weak_ref_create(other);
			desc = new Formatter("{0}", new FunctionProvider(function() {
				if weak_ref_alive(ref) {
					return ref.ref.desc;
				}
				return "";
			}))
		}
	}
	
	/// @func add_intent
	static add_intent = function(intent) {
		return timeline_entry.add_intent(intent);
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
	
	static multitarget = function(targets, func) {
		var item = new MultiTargetItem(owner, targets, func);
		consume(item);
		return item;
	}
	
	/// @func hit
	/// Shorthand for targeting the player with an attack
	static hit = function(damage) {
		return attack(TARGETS.PLAYER, damage)
	}
	
	/// @func as_damage
	/// Shorthand for getting a damage provider from input
	static as_damage = function(value, target = TARGETS.PLAYER) {
		if is_method(value) {
			value = recast_func(value);
			value = new FunctionProvider(value);
		}
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


function EnemyMoveMultiTarget(owner) : EnemyMove(owner) constructor {
	delete timeline_entry;
	
	static consume = function(action) {
		CombatRunner.enqueue(action)
	}
}