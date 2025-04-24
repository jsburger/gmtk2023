/// @description hi
entries = [];
ymax = bbox_bottom - bbox_top - 64;

object_hints = ds_map_create();

update = function(update_positions = true) {
	array_clear(entries);
	gather_timeline_entries(entries);
	
	var min_alpha = 0,
		total_height = 0;
	for (var i = 0; i < array_length(entries); i++) {
		if is_instanceof(entries[i], TimelineEnemyMove) entries[i].reset_height();
		total_height += entries[i].height;
	}
	var scale = ymax/total_height,
		current_height = 32;
	for (var i = 0; i < array_length(entries); i++) {
		var entry = entries[i];
		
		min_alpha = min(entry.alpha, min_alpha)
		if !entry.initialized {
			entry.initialized = true;
			entry.y = current_height;
			entry.ygoal = entry.y;
			
			entry.alpha = min_alpha - 1/3;
			min_alpha = entry.alpha;
		}
		if update_positions {
			entry.ygoal = current_height;
		}
		current_height += entry.height * scale;
	}
}

update()

function entry_position_x(entry) {
	return (x - TIMELINE_GAP/2) + 32 * (1 - entry.alpha);
}
function entry_position_y(entry) {
	return (bbox_top + entry.y)
}

test_hoverables = function(tester) {
	for (var i = 0; i < array_length(entries); i++) {
		var entry = entries[i],
			xpos = entry_position_x(entry),
			ypos = entry_position_y(entry);
		tester.test(entry, xpos - 32, ypos - 32, xpos + 32, ypos + 32, depth - .1 * i);
		entry.test_children(tester, xpos, ypos, depth - 1 - .1 * i);
	}
}