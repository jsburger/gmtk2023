function array_random(array) {
	return array[irandom(array_length(array) - 1)]
}

/// Mutates and resizes an array
function array_filter_smart(array, filter) {
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

/// Takes all items from from and puts them in to
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