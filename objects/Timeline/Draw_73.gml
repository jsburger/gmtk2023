/// @description 

#macro TIMELINE_GAP 80

draw_self();
var draw_x = x - TIMELINE_GAP/2,
	draw_y = bbox_top;
for (var i = 0; i < array_length(entries); i++) {
	var entry = entries[i];
	if entry.alpha > 0 {
		draw_set_alpha(entry.alpha)
		entry.draw(draw_x + 32 * (1 - entry.alpha), draw_y + entry.y)
	}
}
draw_set_alpha(1)