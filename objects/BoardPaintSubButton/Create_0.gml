/// @description 

color = -1
image_speed = 0

on_click = function() {
	obj_board.paintcolor = color
	with BoardPaintSubButton image_blend = c_white
	image_blend = c_gray
}

can_click = function() {
	return visible
}