function array_random(array) {
	return array[irandom(array_length(array) - 1)]
}

/// Mutates and resizes an array
function array_filter_resize(array, filter) {
	array_resize(array, array_filter_ext(array, filter))
}

/// Creates a new array with all instances of a given object
function array_build(object) {
	var a = array_create(instance_number(object));
	var i = 0;
	with object {
		a[i++] = self
	}
	return a;
}

/// Creates an array of all instances matching the filter function
function array_build_filtered(object, filter) {
	var a = [];
	with object {
		if filter(self) array_push(a, self)
	}
	return a;
}

/// Creates an array of all instances in random order
function array_build_shuffled(object) {
	var a = array_build(object);
	array_shuffle_ext(a);
	return a;
}

/// Takes all items from From and puts them in To
function array_transfer(to, from) {
	if array_length(from) > 0 {
		repeat(array_length(from)) {
			array_push(to, array_pop(from))
		}
	}
}

/// Returns an array of all values in a struct
function struct_get_values(struct) {
	var names = struct_get_names(struct),
		array = array_create(array_length(names));
	
	for (var i = 0, l = array_length(names); i < l; i++) {
		array[i] = struct_get(struct, names[i]);
	}
	return array;
}

/// Clears a struct of all keys.
function struct_clear(struct) {
	for (var names = struct_get_names(struct), i = 0, l = array_length(names); i < l; i++) {
		struct_remove(struct, names[i])
	}
}

/// Clears an array of all values
function array_clear(array) {
	array_delete(array, 0, array_length(array))
}

/// Creates a new array containing arrays of the given height;
function array_create_2d(width, height = 0) {
	var a = array_create(width);
	for (var i = 0; i < width; i++) {
		a[i] = array_create(height)
	}
	return a;
}

/// Returns an array of COUNT non-repeating numbers up to MAX, includes 0, does not include MAX
function random_numbers(count, max_number) {
	var indices = array_create(max_number);
	for (var i = 0; i < max_number; i++) {
		indices[i] = i;
	}
	array_shuffle_ext(indices);
	var ret = [];
	for (var i = 0; i < count; i++) {
		var index = i mod max_number;
		array_push(ret, indices[index])
		if index == 0 && i > 0 {
			array_shuffle_ext(indices)
		}
	}
	return ret
}

/// Returns a random entry from an array, excluding one index from the possible results
function array_random_excluding(array, excluded_index) {
	var rand = irandom(array_length(array) - 2);
	if rand >= excluded_index {
		rand += 1;
	}
	return array[rand];
}

function array_clone_shallow(array) {
	var c = [];
	array_copy(c, 0, array, 0, array_length(array))
	return c;
}

/// Finds the index that contains a specific value
function array_find(array, value) {
	if array_contains(array, value) {
		for (var i = 0, length = array_length(array); i < length; i++) {
			if array[i] == value return i
		}
	}
	return undefined;
}


/// Returns an index that is always in bounds of the array
function array_wrap_index(array, n) {
	if n < 0 {
		var length = array_length(array);
		return length - ((-n) mod length)
	}
	return n mod array_length(array)
}

/// Returns a new array with contents of source, sized to length
function array_clip(source, start, length) {
	var ret = [];
	array_copy(ret, 0, source, start, length);
	return ret;
}

/// Modifies the original array to contain rejects, and returns a new filtered array.
function array_split_in_place(array, filter, return_failures = false) {
	var success = [],
		count = 0;
	for (var i = 0, l = array_length(array); i < l; i++) {
		if filter(array[i]) xor return_failures {
			array_push(success, array[i]);
		}
		else {
			array[count] = array[i]
			count++;
		}
	}
	array_resize(array, count);
	return success;
}

/// Returns a struct of two new arrays, one filtered and one rejects
function array_split(array, filter) {
	var filtered = [],
		rejected = [];
	for (var i = 0, l = array_length(array); i < l; i++) {
		if filter(array[i]) {
			array_push(filtered, array[i]);
		}
		else {
			array_push(rejected, array[i]);
		}
	}
	return {
		filtered,
		rejected
	}
}

/// Runs the generator function for [0-n), and returns an array with the results.
function memoize_array(n, generator) {
	var results = array_create(n);
	for (var i = 0; i < n; i++) {
		results[i] = generator(i)
	}
	return results;
}


/// @param {Array<Any>} array
/// @param {Function, String} mapping Function that returns a number, or a string to sort by variable
/// @desc Retuns a new array, sorted in ascending order after being mapped by the given function.
function array_mapped_sort(array, mapper, ascending = true) {
	static sorting_grid = ds_grid_create(2, 10);
	var l = array_length(array);
	ds_grid_resize(sorting_grid, 2, l);
	if is_string(mapper) {
		for(var i = 0; i < l; i++) {
			ds_grid_set(sorting_grid, 0, i, array[i])
			ds_grid_set(sorting_grid, 1, i, variable_instance_get(array[i], mapper))
		}
	}
	else {
		for(var i = 0; i < l; i++) {
			ds_grid_set(sorting_grid, 0, i, array[i])
			ds_grid_set(sorting_grid, 1, i, mapper(array[i]))
		}
	}
	
	ds_grid_sort(sorting_grid, 1, ascending)
	
	var a = array_create(l);
	for(var i = 0; i < l; i++) {
		a[i] = ds_grid_get(sorting_grid, 0, i)
	}
	return a
}
