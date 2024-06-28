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