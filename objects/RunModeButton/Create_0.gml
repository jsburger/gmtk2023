/// @description 
on_click = function() {
	fade_to(RoomRunMode);
	global.run_mode = true;
}
can_click = function() {
	return !instance_exists(FadeTo)
}