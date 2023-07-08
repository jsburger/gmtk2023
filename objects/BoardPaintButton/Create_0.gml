/// @description 

for (var i = 0; i <= MANA.MAX; i++) {
	with instance_create_depth(bbox_left + (sprite_width + 1) * (i / MANA.MAX), bbox_bottom + 1, depth, BoardPaintSubButton) {
		color = i - 1
		image_index = i
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