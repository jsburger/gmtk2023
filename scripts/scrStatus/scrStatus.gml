function StatusHolder(creator) constructor {
	status_map = {};
	
	owner = creator;
	
	static add_status = function(status_key, strength) {
		if struct_exists(status_map, status_key) {
			var status = struct_get(status_map, status_key);
			status.on_stack(strength);
		}
		else {
			var status = status_get(status_key, strength)
			status.set_owner(owner)
			status.on_add()
			status.set_holder(self);
			struct_set(status_map, status_key, status)
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
	
}

function status_register(name, statusFactory) {
	static statuses = ds_map_create();
	ds_map_add(statuses, name, statusFactory)
}
function status_get_registry() {
	return status_register.statuses;
}
function status_get_prototype(name) {
	return status_get_registry()[? name]
}
function status_get(name, count) {
	var factory = status_get_prototype(name);
	var s = factory(count)
	s.key = name;
	return s;
}




function Status(Strength) constructor {
	strength = Strength;
	
	visible = true;
	sprite_index = spr_chip;
	name = "Status"
	desc = "Description"
	
	key = "Undefined" //Do not set this. It is used to refer back to its prototype.
	
	owner = noone;
	holder = undefined;
	
	// Controls if the status ticks down every turn
	is_timer = false;
	
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
	}
	
	static knock = function() {
		strength -= 1;
		if strength <= 0 {
			clear()
		}
	}
	
	static on_hurt = function() {
		
	}
	
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

	static on_add = function() {
		
	}
	static on_remove = function() {
		
	}
	static on_stack = function(amount) {
		strength += amount;
	}
}

status_register("Strength", function(count) {return new StatusStrength(count)})

function StatusStrength(Strength) : Status(Strength) constructor {
	sprite_index = sprIntentAttack;
	name = "Strength"
	desc = "Increases damage dealt."
	
	static get_attack_bonus = function() {
		return strength;
	}
}

status_register("Freeze", function(count) {return new StatusFreeze(count)})

function StatusFreeze(Strength) : Status(Strength) constructor {

	name = "Frozen"
	desc = "Increases the mana cost of abilities."
	sprite_index = sprStatusFrost;
	
	tickable_register(self)
	
	static tick = function() {
		if strength > 0 {
			var frozen = array_build_filtered(obj_block, function(inst) {return inst.frozen})
			if array_length(frozen) < strength {
				// Gather freezable bricks
				var bricks = array_build_filtered(obj_block, function(inst) {
					return inst.freezable && !inst.frozen;
				}),
					dif = strength - array_length(frozen);
				// Exit early if no bricks to freeze
				if array_length(bricks) <= 0 {
					exit;
				}
				// Randomize array order
				array_shuffle_ext(bricks)
				// Freeze bricks
				repeat(min(dif, array_length(bricks))) {
					var brick = array_pop(bricks);
					brick.set_frozen(true);
					// Sparkle Effect
					with (instance_create_layer(brick.x,brick.y, "FX", obj_fx)) {
						sprite_index = spr_hit_small
					}
				}
			}
		}
	}
	
	static on_remove = function() {
		if strength > 0 {
			with obj_block {
				if frozen {
					set_frozen(false, true)
				}
			}
		}
		strength = 0;
	}
	
	/// @param {Struct.AbilityCostModifier} modifier
	static modify_ability_cost = function(modifier) {
		var position = modifier.ability.position + 1,
			posmax = 5,
			index = strength mod posmax,
			base = strength div posmax;
		if position <= index {
			base += 1;
		}
		if base > 0 {
			for (var i = 0; i < MANA.MAX; i++) {
				modifier.add(i, base)
			}
		}
	}
	
}