function Pool() {
	entries = [];
	total_weight = 0;
	
	static add_entry = function(value, weight) {
		array_push(entries, [value, weight])
		total_weight += weight
	}
	static pull = function() {
		var l = array_length(entries);
		if l == 0 return undefined
		if l == 1 return entries[0][0]
		
		var rand = random(total_weight),
			accumulator = 0;
		for (var i = 0; i < l; i++) {
			accumulator += entries[i][1]
			if accumulator >= rand return entries[i][0]
		}
		return entries[l - 1][0];
	}
	/// Returns if the given value was found and removed
	static remove_entry = function(value) {
		for (var i = 0; i < array_length(entries); i++) {
			if entries[i][0] == value {
				total_weight -= entries[i][1]
				array_delete(entries, i, 1)
				return true
			}
		}
		return false
	}
}