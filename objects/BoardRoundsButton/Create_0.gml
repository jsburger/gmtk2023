/// @description 

on_click = function() {
	mark_level_changed()
	current_level.info.rounds += sign(image_xscale)
}

can_click = function() {
	return visible
}