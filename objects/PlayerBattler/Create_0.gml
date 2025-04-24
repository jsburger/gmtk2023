/// @description 

// Inherit the parent event
event_inherited();

statuses.is_player = true;

set_hp(global.player_stats.hp)
set_hp_max(50)

status_x = function() {
	gml_pragma("forceinline");
	return bbox_right + 32;
}
status_y = function() {
	gml_pragma("forceinline")
	return bbox_top;
}