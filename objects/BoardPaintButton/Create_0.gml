/// @description 

for (var i = 0; i <= COLORS.GREEN; i++) {
	with instance_create_depth(bbox_right + 1, bbox_top + (24 * image_yscale) * i, depth, BoardPaintSubButton) {
		color = i - 1
		visible = other.visible
		image_xscale = other.image_xscale
		image_yscale = other.image_yscale
	}
}

on_click = function() {
	if obj_board.mode == editorMode.build {
		obj_board.mode = editorMode.paint
		image_blend = c_gray
	}
	else {
		obj_board.mode = editorMode.build
		image_blend = c_white
	}
}

can_click = function() {
	return visible
}