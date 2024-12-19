function InstanceFinder(object) constructor {
	search_object = object;
	
	filters = [];
	prefers = [];
	sorter = undefined;
	
	/// @ignore
	static filter_func = function(inst) {
		for (var i = 0, l = array_length(filters); i < l; i++) {
			if filters[i](inst) {
				continue;
			}
			return false;
		}
		return true;
	}
	
	/// @param {Function} func
	static filter = function(func) {
		array_push(filters, func);
		return self;
	}
	/// @param {Function} func
	static prefer = function(func) {
		array_push(prefers, func)
		return self;
	}
	
	
	/* Consider a color selection and a distance sort. Start with a filter for colorable.
	Then, a prefer for color == gray. Let's say there are 10 gray bricks, and 100 other colors.
	If we get 20 bricks with no sort, we will get 10 gray then 10 other, RANDOM bricks.
	We can sort this output by distance so that all bricks, regardless of color, are in distance order.
	If we wanted the 20 NEAREST bricks though, we would need to sort before selection.
	That is what this input does.
	If we sort before selection, the 100 other bricks will be sorted by distance beforehand.
	So we will get the 10 gray bricks, in distance order, then the 10 closest other bricks in order.
	*/
	/// @desc Sorts output before selection.
	/// This is different from sorting the output. See comment for example.
	/// @param {Function} func
	static sort = function(func) {
		sorter = func;
		return self;
	}
	
	/// @desc Returns a new array of instances matching all criteria.
	/// @param {Real} count Amount of instances to look for. Can be infinite to return all results;
	static get = function(count) {
		// No object
		if !instance_exists(search_object) {
			return [];
		}
		// Odd case but sets precedent
		if array_length(filters) == 0 && array_length(prefers) == 0 {
			var working = array_build_shuffled(search_object);
			if sorter != undefined {
				array_sort(working, sorter);
			}
			array_resize(working, min(count, array_length(working)))
			return working;
		}
		// Filters
		var filtered = array_build_filtered(search_object, filter_func);
		array_shuffle_ext(filtered);
		if array_length(prefers) == 0 {
			if sorter != undefined array_sort(filtered, sorter)
			array_resize(filtered, min(count, array_length(filtered)))
			return filtered;
		}
		// Preferences
		var layers = [filtered];
		for (var i = 0; i < array_length(prefers); i++) {
			array_push(layers, array_split_in_place(layers[i], prefers[i]))
		}
		
		// Gather results
		var results = [],
			n = 0;
		for (var a = array_length(prefers) - 1; a >= 0; a--) {
			if array_length(layers[a]) == 0 continue;
			if sorter != undefined {
				array_sort(layers[a], sorter);
			}
			var amount = min(array_length(layers[a]), count - n);
			array_copy(results, array_length(results), layers[a], 0, amount);
			n += amount;
			
			if n >= count return results;
		}
		return results;
	}
	
}