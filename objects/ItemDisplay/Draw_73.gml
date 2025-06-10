/// @description 
var hovered_index = -1;
ITEM_LOOP {
	if item.hovered {
		hovered_index = index;
	}
}
if (hovered_index > -1) {
	var item = global.items[hovered_index];
	draw_textbox(bbox_left + 32 * (hovered_index + 2), y, [item.name, item.desc]);
}