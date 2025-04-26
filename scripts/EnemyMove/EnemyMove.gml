///Base Class for all enemy moves
function EnemyMove(_owner) : CombatInterface() constructor {
	set_owner(_owner)
	
	providers = []
	actions = []
	
	timeline_entry = new TimelineEnemyMove(_owner);
	
	is_rerollable = true;
	intent_auto = true;	
	
	/// @func add_intent
	/// @returns {Struct.Intent}
	static add_intent = function(intent) {
		return timeline_entry.add_intent(intent);
	}
	
	static last_intent = function() {
		return array_last(timeline_entry.intents);
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
	
	static try_intent = function(intent) {
		if (intent_auto && is_real(intent.value)) {
			add_intent(intent);
		}
	}
	
	/// @func hit
	/// Shorthand for targeting the player with an attack
	static hit = function(damage) {
		if (intent_auto && (
			(is_provider(damage) && !is_instanceof(damage.inner, FunctionProvider))
			|| is_real(damage))) {
			add_intent(new Intent(sprIntentAttack, damage)
				.with_desc(format("Deal {0} damage.", damage)))
		}
		return attack(TARGETS.PLAYER, damage)
	}
	
	static block = function(amount) {
		try_intent(new Intent(sprIntentDefend, amount)
			.with_desc(format("Gain {0} block.", amount)));
		return defend(TARGETS.SELF, amount)
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
		try_intent(new Intent(sprStatusFrost, value)
			.with_desc(format("Inflict {0} Freeze.", value)));
		return apply_status(TARGETS.PLAYER, STATUS.FREEZE, value)
	}
	
	/// Shorthand for applying poison to the player
	static poison = function(value) {
		try_intent(new Intent(sprStatusPoison, value)
			.with_desc(format("Inflict {0} Poison.", value)));
		return apply_status(TARGETS.PLAYER, STATUS.POISON, value)
	}
	
	/// Shorthand for applying strength to self
	static buff_strength = function(value) {
		try_intent(new Intent(sprStatusStrength, value)
			.with_desc(format("Gain {0} Strength.", value)));
		return apply_status(TARGETS.SELF, STATUS.STRENGTH, value)
	}
	
	static burn = function(value) {	
		var func = method({value}, function() {
				bricks_burn(value)
			}),
			item = run(func);
		item.delay = 15;
		try_intent(new Intent(sprStatusBurn, value)
			.with_desc(format("Burn {0} bricks.", value)));
		return item;
	}
	
	static curse = function(count) {
		try_intent(new Intent(sprCurseProjectile, count)
			.with_desc(format("Curse {0} bricks.", count)))
		//Fuck it we copy paste
		var act = new FunctionItem(owner, anonymous(bricks_curse), count);
		consume(act);
		return act;
	}
}


function EnemyMoveMultiTarget(owner) : EnemyMove(owner) constructor {
	delete timeline_entry;
	intent_auto = false;
	static consume = function(action) {
		CombatRunner.enqueue(action)
	}
}