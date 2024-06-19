/// @description 
array_foreach(entries, function(entry, index) {
	entry.y = lerp(entry.y, entry.ygoal, .12)
	entry.alpha = min(entry.alpha + .04, 1)
})