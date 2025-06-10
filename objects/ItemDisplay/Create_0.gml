/// @description 
test_hoverables = function(tester) {
	ITEM_LOOP {
		tester.test_box(item, bbox_left + 32 * (index + 1), y, 32, depth - index);
	}
}