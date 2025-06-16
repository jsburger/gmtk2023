/// @description 
on_click = function() {
	fade_to(RoomRunMode);
}
can_click = function() {
	return !instance_exists(FadeTo)
}