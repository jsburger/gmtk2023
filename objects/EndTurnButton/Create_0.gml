/// @description 

on_click = function() {
	if combat_active() && CombatRunner.is_player_turn {
		player_turn_end()
	}
}