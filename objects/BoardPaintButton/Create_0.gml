/// @description 

for (var i = 0; i <= COLORS.YELLOW + 1; i++) {
	with instance_create_depth(bbox_right + 1, bbox_top + (24 * image_yscale) * i, depth, BoardPaintSubButton) {
		color = i - 1
		visible = other.visible
		image_xscale = other.image_xscale
		image_yscale = other.image_yscale
	}
}

on_click = function() {
	if obj_board.mode != editorMode.paint {
		obj_board.enter_paint_mode()
	}
	else {
		obj_board.exit_paint_mode()
	}
}

can_click = function() {
	return visible
}

activate = function() {
	image_blend = c_gray;
}
deactivate = function() {
	image_blend = c_white;
}