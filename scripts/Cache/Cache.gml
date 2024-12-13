/*function MapCache() constructor {
	values = {};
	
	static has = function(key) {
		return struct_exists(values, key)
	}
	
	static get = function(key) {
		return struct_get(values, key);
	}
	
	static set = function(key, value) {
		var previous = get(key);
		struct_set(values, key, value);
		return previous;
	}
} */

/// Caches values per frame.
function FrameCache(func) constructor {
	
	getter = func;
	last_frame = -100;
	last_value = undefined;
	
	static get = function() {
		if last_frame == current_frame {
			return last_value;
		}
		else {
			last_frame = current_frame;
			if argument_count > 0 {
				arguments_pack
				last_value = method_call(getter, args);
			}
			else {
				last_value = getter();
			}
			return last_value;
		}
	}
}