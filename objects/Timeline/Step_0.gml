/// @description 
array_foreach(entries, function(entry, index) {
	entry.y = lerp(entry.y, entry.ygoal, .12)
	entry.alpha = min(entry.alpha + .04, 1)
})

var changed = false;
var map = object_hints;
with parBoardObject if timeline_entry != undefined {
	if !ds_map_exists(map, object_index) {
		ds_map_add(map, object_index, timeline_entry);
		changed = true;
	}
}
if ds_map_size(object_hints) > 0 {
	var keys = ds_map_keys_to_array(object_hints, []);
	for (var i = 0; i < array_length(keys); i++) {
		if !instance_exists(keys[i]) {
			ds_map_delete(object_hints, keys[i])
			changed = true;
		}
	}
}
if changed update()