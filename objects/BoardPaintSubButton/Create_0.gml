/// @description 

color = -1
image_speed = 0

on_click = function() {
	obj_board.enter_paint_mode(color)
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