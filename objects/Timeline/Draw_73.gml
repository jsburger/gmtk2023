/// @description 

#macro TIMELINE_GAP 80

draw_self();
for (var i = 0; i < array_length(entries); i++) {
	var entry = entries[i];
	if entry.alpha > 0 {
		draw_set_alpha(entry.alpha)
		entry.draw(entry_position_x(entry), entry_position_y(entry))
	}
}
draw_set_alpha(1)