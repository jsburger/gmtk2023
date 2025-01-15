/// @description hi
entries = [];
ymax = bbox_bottom - bbox_top - 64;

object_hints = ds_map_create();

update = function(update_positions = true) {
	entries = [];
	gather_timeline_entries(entries)
	
	var new_entries = array_filter(entries, function(entry, index) {
		if !struct_exists(entry, "initialized") {
			trace(entry)
		}
		return !entry.initialized;
	});
	var min_alpha = 1/3;
	for (var i = 0; i < array_length(entries); i++) {
		var entry = entries[i]
		var index = ((i + .5)/(array_length(entries)));
		
		min_alpha = min(entry.alpha, min_alpha)
		if !entry.initialized {
			entry.y = index * ymax;
			entry.ygoal = entry.y
			entry.initialized = true;
			
			entry.alpha = min_alpha - 1/3;
			min_alpha = entry.alpha;
		}
		if update_positions {
			entry.ygoal = index * ymax
		}
	}
}

update()