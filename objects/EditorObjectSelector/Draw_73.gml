/// @description 
draw_rectangle_simple(cam_x, cam_y, cam_right, cam_bottom, c_black, .5)

mouse_found = false;
hovered = false;

var list = Board.placers,
	hovered_index = -1;
for (var i = 0; i < array_length(list); i++) {
	get_info(i);
	var col = c_white;
	if hovered {
		hovered_index = i;
	}
	else {
		if Board.placer_index != i col = c_gray;
	}
	draw_sprite_ext(sprEnemyBgSmall, 0, xmid, ymid, 1, 1, 0, c_gray, .7);
	draw_sprite_ext(sprEnemyFrameSmall, 0, xmid, ymid, 1, 1, 0, col, .7);
	list[i].draw_preview(xmid, ymid);
}
if (hovered_index > -1) {
	get_info(hovered_index);
	list[hovered_index].draw_variants(xmid, ymid, 32);
}