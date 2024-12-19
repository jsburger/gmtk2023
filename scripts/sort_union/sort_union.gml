/// Returns a function which combines the two sort functions
function sort_union(first, second) {
	return method({first, second}, function(a, b) {
		var result = first(a, b);
		if result == SORTING.EQUAL {
			return second(a, b);
		}
		return result;
	})
}