function StatusHolder(creator) constructor {
	status_map = {};
	
	owner = creator;
	
	static add_status = function(status_key, strength) {
		if struct_exists(status_map, status_key) {
			var status = struct_get(status_map, status_key);
			status.on_stack(strength);
		}
		else {
			var status = status_get(status_key, strength);
			status.set_owner(owner)
			status.set_holder(self);
			struct_set(status_map, status_key, status)
			status.add()
		}
		return self
	}
	
	
	static status_remove = function(key) {
		struct_remove(status_map, key)
	}
	
	#macro __status_loop for (var statuses = struct_get_values(status_map), i = 0, l = array_length(statuses); i < l; i++)
	
	static on_turn_end = function() {
		__status_loop {
		    var s = statuses[i];
			var finished = s.on_turn_end();
			if finished {
				status_remove(s.key)
				s.on_remove()
			}
		}
	}
	
	static on_turn_start = function() {
		__status_loop {
		    var s = statuses[i];
			s.on_turn_start();
		}
	}
	
	static step = function() {
		__status_loop {
			statuses[i].step();
		}
	}
	
	static on_ability_used = function() {
		__status_loop {
			var s = statuses[i];
			if struct_exists(s, "after_ability_used") {
				s.after_ability_used()
			}
		}
	}
	
	static clear = function(doRemove = true) {
		if doRemove {
			__status_loop {
			    var s = statuses[i];
				s.on_remove()
			}
		}
		struct_clear(status_map)
	}
	
	static get_attack_bonus = function() {
		return array_reduce(struct_get_values(status_map), function(prev, current) {
			return prev + current.get_attack_bonus()
		}, 0)
	}
	
	static reduce = function(func, initial = 0) {
		return array_reduce(struct_get_values(status_map), func, initial);
	}
	
	/// @returns {Array<Struct.Status>}
	static filter = function(func) {
		return array_filter(struct_get_values(status_map), func)
	}
	
	static find = function(key) {
		return struct_get(status_map, key);
	}
	
	
	static draw = function(x, y) {
		var gap = 68;
		__status_loop {
			var s = statuses[i],
				draw_x = x + gap * i;
			draw_sprite(s.sprite_index, sprite_get_animation_frame(s.sprite_index), draw_x, y)
			draw_text(draw_x + 22, y + 22, string(s.strength))
			if mouse_in_rectangle(draw_x - 32, y - 32, draw_x + 32, y + 32) {
				draw_textbox(draw_x, y, [s.name, s.desc])
			}
		}
	}
	
	static draw_player = function(x, y) {
		var gap = 68;
		__status_loop {
			var s = statuses[i],
				draw_x = x + 40 * (i div 3),
				draw_y = y + gap * (i mod 3);
			draw_sprite(s.sprite_index, sprite_get_animation_frame(s.sprite_index), draw_x, draw_y)
			draw_text(draw_x + 22, draw_y + 22, string(s.strength))
			if mouse_in_rectangle(draw_x - 32, draw_y - 32, draw_x + 32, draw_y + 32) {
				draw_textbox(draw_x, draw_y, [s.name, s.desc])
			}
		}
	}
	
}

function status_register(name, statusFactory) {
	static _statuses = ds_map_create();
	ds_map_add(_statuses, name, statusFactory)
	return name;
}
function status_get_registry() {
	return status_register._statuses;
}
function status_get_prototype(name) {
	return status_get_registry()[? name]
}
/// @returns {Struct.Status}
function status_get(name, count) {
	var factory = status_get_prototype(name);
	var s = factory(count)
	s.key = name;
	return s;
}

global.statuses = {}
#macro STATUS global.statuses


function Status(Strength) constructor {
	strength = Strength;
	
	visible = true;
	sprite_index = sprChip;
	name = "Status"
	desc = "Description"
	
	key = "Undefined" //Do not set this. It is used to refer back to its prototype.
	
	owner = noone;
	holder = undefined;
	
	// Controls if the status ticks down every turn
	is_timer = false;
	
	// Generic use provider for getting effect strength
	strength_provider = new FunctionProvider(function() {return strength})
	
	timeline_entry = undefined;
	
	static set_owner = function(Owner) {
		owner = Owner
	}
	
	static set_holder = function(Holder) {
		holder = weak_ref_create(Holder)
	}
	
	/// Call to get rid of this status.
	static clear = function(proc_remove = true) {
		if proc_remove on_remove()
		if weak_ref_alive(holder) {
			var h = holder.ref;
			h.status_remove(key)
		}
		if timeline_entry != undefined Timeline.update()
	}
	
	static knock = function() {
		strength -= 1;
		if strength <= 0 {
			clear()
		}
	}
	
	static on_hurt = function() {};
	
	static step = function() {};
	
	static get_attack_bonus = function() {
		return 0;
	}
	
	static on_turn_end = function() {
		if is_timer {
			strength -= 1;
		}
		if strength <= 0 {
			return true
		}
		return false
	}
	static __on_turn_end_internal = on_turn_end
	
	static on_turn_start = function() {
		
	}
	static __on_turn_start_internal = on_turn_start

	/// Called by statusHolder to initialize the status
	static add = function() {
		on_add()
		if timeline_entry != undefined Timeline.update();
	}
	/// Run when a status is added to a holder, not when it is stacked.
	static on_add = function() {}
	static on_remove = function() {
		
	}
	static on_stack = function(amount) {
		strength += amount;
	}
}

STATUS.STRENGTH = status_register("Strength", function(count) {return new StatusStrength(count)})

function StatusStrength(Strength) : Status(Strength) constructor {
	sprite_index = sprStatusStrength;
	name = "Strength"
	desc = "Increases damage dealt."
	
	static get_attack_bonus = function() {
		return strength;
	}
}

STATUS.FREEZE = status_register("Freeze", function(count) {return new StatusFreeze(count)})


function StatusFreeze(Strength) : Status(Strength) constructor {

	name = "Frozen"
	desc = "Increases the mana cost of abilities."
	sprite_index = sprStatusFrost;
	
	static step = function() {
		static finder = new InstanceFinder(parBoardObject).filter(brick_can_freeze);
		if strength > 0 {
			var frozen = 0;
			with parBoardObject if is_frozen frozen++;
			if frozen < strength {
				// Gather freezable bricks
				var dif = strength - frozen,
					bricks = finder.get(dif);
				// Freeze bricks
				for(var i = 0; i < array_length(bricks); i++) {
					var brick = bricks[i];
					brick.set_frozen(true);
					// Sparkle Effect
					with (instance_create_layer(brick.x,brick.y, "FX", obj_fx)) {
						sprite_index = sprFXHitSmall
					}
				}
				if i > 0 {
					// Play Sound
					sound_play_random(sndApplyFreeze);
				}
			}
		}
	}
	
	static on_remove = function() {
		if strength > 0 {
			with parBoardObject {
				if is_frozen {
					set_frozen(false, true)
				}
			}
		}
		strength = 0;
	}
	
	/// @param {Struct.AbilityCostModifier} modifier
	static modify_ability_cost = function(modifier) {
		var position = modifier.ability.position + 1,
			posmax = array_length(global.player_stats.abilities),
			index = strength mod posmax, //How many abilities are in a partial lap
			base = strength div posmax; //How many laps the freeze count makes
		if position <= index { //If this is in a partial lap
			base += 1;
		}
		if base > 0 {
			for (MANA_LOOP) {
				modifier.add(i, base)
			}
		}
	}
}

function StatusBurn(count) : Status(count) constructor {
	sprite_index = sprStatusBurn;
	name = "Burned";
	desc = new Formatter("YOUVE BEEN BURNED!!!! \nTAKE {0} DAMAGE WHEN YOU CAST SPELLS!", strength_provider)
	
	static after_ability_used = function() {
		static interface = new CombatInterface();
		interface.run(function(){battler_hurt(CombatRunner.player, strength, self)})
		// Play Sound
		sound_play_random(sndBurn);		
	}
	
	static on_turn_end = function() {
		strength = 0;
		return true;
	}
}
STATUS.BURN = status_register("Burn", function(count){return new StatusBurn(count)})


function StatusPoison(count) : Status(count) constructor {
	sprite_index = sprStatusPoison;
	name = "Poisoned"
	desc = new Formatter("Take {0} Damage at the end of your turn.\nBreak poisoned bricks to reduce this!", strength_provider)
	
	timeline_entry = new TimelineBoardNote(sprite_index, desc)
	
	static on_turn_end = function() {
		static interface = new CombatInterface();
		interface.owner = self;
		interface.attack(CombatRunner.player, strength)
		sound_play_random(sndPoison);
		//battler_hurt(PlayerBattler, strength, self);
	}
	
	static on_remove = function() {
		if strength > 0 {
			with parBoardObject {
				if is_poisoned {
					set_poisoned(false, true)
				}
			}
		}
		strength = 0;
	}
	
	static step = function() {
		static finder = new InstanceFinder(parBoardObject).filter(brick_can_poison);
		if strength > 0 {
			var poisoned = 0;
			with parBoardObject if is_poisoned poisoned++;
			if poisoned < strength {
				// Gather poisonable bricks
				var dif = strength - poisoned,
					bricks = finder.get(dif);
				// Poison bricks
				for(var i = 0; i < array_length(bricks); i++) {
					var brick = bricks[i];
					brick.set_poisoned(true);
					// Sparkle Effect
					with (instance_create_layer(brick.x,brick.y, "FX", obj_fx)) {
						sprite_index = sprFXPuffSmall
					}
				}
				// Play Sound
				if i > 0 sound_play_pitch(sndApplyPoison, random_range(.9, 1.1));
			}
		}
	}
	
}
STATUS.POISON = status_register("Poisoned", function(count){return new StatusPoison(count)})