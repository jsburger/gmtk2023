function array_random(array) {
	return array[irandom(array_length(array) - 1)]
}

/// Mutates and resizes an array
function array_filter_smart(array, filter) {
	array_resize(array, array_filter_ext(array, filter))
}