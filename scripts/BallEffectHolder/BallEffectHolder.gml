function BallEffectHolder() : BallEffect() constructor {
	effects = [];
	
	
	// Magic code block which makes all of the functions on the holder
	// call that function on all of its held effects
	var static_struct = static_get(BallEffect),
		names = struct_get_names(static_struct);
	for (var i = 0; i < array_length(names); i++) {
		var hash = variable_get_hash(names[i]),
			name = names[i];
		if is_method(struct_get(static_struct, name)) && name != "clear" {
			struct_set(self, name, method({effects, hash}, function() {
				var length = array_length(effects);
				if length <= 0 return false;
				arguments_pack;
				var need_refresh = false,
					return_value = false;
				for (var i = 0; i < length; i++) {
					var func = struct_get_from_hash(effects[i], hash)
					with effects[i] {
						return_value = method_call(func, args);
					}
					if effects[i].wants_deletion {
						need_refresh = true;
					}
					// Exit early if true for can_ scripts
					if (return_value) {
						break;
					}
				}
				
				if need_refresh {
					var ball = args[0];
					for (var i = length - 1; i >= 0; i--) {
						if effects[i].wants_deletion {
							effects[i].on_remove(ball);
						}
						else {
							effects[i].on_refresh(ball);
						}
						// Disable stat changes
						for (var o = array_length(effects[i].stat_changes) - 1; o >= 0; o--) {
							effects[i].stat_changes[o].reverse(ball);
						}
					}
					array_filter_resize(effects, function(effect) {return !effect.wants_deletion})
					length = array_length(effects)
					for (var i = 0; i < length; i++) {
						// Re-enable stat changes
						for (var o = 0; o < array_length(effects[i].stat_changes); o++) {
							effects[i].stat_changes[o].apply(ball)
						}
						effects[i].on_reapply(ball);
					}
				}
				
				return return_value;
			}))
		}
	}
	
	//hooks = {};
	
	/// @param {Id.Instance} ball
	/// @param {Struct.BallEffect} effect
	static add_effect = function(ball, effect) {
		// Store effect
		array_push(effects, effect);
		
		// Find hooks and cache
		//var name_max = struct_names_count(effect),
		//	names = struct_get_names(effect);
		//for (var i = 0; i < name_max; i++) {
		//	var name = names[i];
		//	if is_method(struct_get(effect, names[i])) {
		//		var list = struct_get(hooks, name);
		//		if list == undefined {
		//			list = [];
		//			struct_set(hooks, name, list)
		//		}
		//		array_push(list, effect)
		//	}
		//}
		
		for (var i = 0; i < array_length(effect.stat_changes); i++) {
			effect.stat_changes[i].apply(ball)
		}
		
		// Run apply hook
		effect.on_apply(ball);
	}
	
	static clear = function(ball) {
		for (var i = array_length(effects) - 1; i <= 0 ; i--) {
			effects[i].on_remove(ball)
		}
		array_clear(effects)
	}
	
	/// Fixes cloning not adjusting the effects array inside the methods
	static clone_update = function() {
		//var names = struct_get_names(self),
		//	values = struct_get_values(self);
		//for (var i = 0; i < array_length(values); i++) {
		//	struct_set(self, names[i], variable_clone(values[i]))
		//}
		//var values = struct_get_values(self);
		//for (var i = 0; i < array_length(values); i++) {
		//	if is_method(values[i]) {
		//		var struct = method_get_self(values[i]);
		//		struct.effects = effects;
		//	}
		//}
		var names = struct_get_names(self);
		for (var i = 0; i < array_length(names); i++) {
			var value = struct_get(self, names[i]);
			if is_method(value) {
				struct_set(self, names[i], method(variable_clone(method_get_self(value)), value))
			}
		}
	}
	
}



function test_cloning() {
	var a = {
		name: "A",
		func: function() {
			trace(name)
		},
		friend : {
			name: "Noone's friend",
			func: function() {
				trace(name)
			}
		}
	}

	a.friends = {
		jimmys: [a.friend]
	};

	var b = variable_clone(a);
	a.friend.name = "A's friend";

	b.friend.name = "B's Friend";
	a.friend.func();
	b.friends.jimmys[0].func();
	// Should output new name, ensures the scope of the method is correctly set
	b.friends.jimmys[0].name = "B's Friend, but nested";
	b.friends.jimmys[0].func();
}
