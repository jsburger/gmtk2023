/// @description 
draw_self();
ITEM_LOOP {
	item.draw(bbox_left + 32 * (index + 1), y);
}