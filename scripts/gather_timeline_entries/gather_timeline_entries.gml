function gather_timeline_entries(input) {
	with CombatRunner {
		
		for (var i = 0; i < array_length(move_queue); i++) {
			array_push(input, move_queue[i].timeline_entry)
		}
		for (var i = 0; i < array_length(enemies); i++) {
			var enemy = enemies[i];
			if enemy.canact && enemy.has_actions() {
				for (var a = 0; a < array_length(enemy.current_actions); a++) {
					array_push(input, enemy.current_actions[a].timeline_entry)
				}
			}
		}
	}
}