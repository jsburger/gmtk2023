/// @description hi
entries = [];
ymax = bbox_bottom - bbox_top;

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
	var new_count = 0;
	for (var i = 0; i < array_length(entries); i++) {
		var entry = entries[i]
		if !entry.initialized {
			entry.y = (i/array_length(entries)) * ymax;
			entry.ygoal = entry.y
			entry.alpha = -new_count/3;
			entry.initialized = true;
			new_count += 1;
		}
		if update_positions {
			entry.ygoal = (i/array_length(entries)) * ymax
		}
	}
}

update()