global.player_stats = {
	hp: 50,
	throws_max: 1,
	throws: 1,
	abilities: []
}



/// Give the player an ability. Accepts Ability instances or a String name
function ability_grant(ability) {
	if is_string(ability) ability = ability_get(ability)
	array_push(global.player_stats.abilities, ability)
	
	with (AbilityButtonHolder) {
		add_button(ability)
	}
}

ability_grant("Hit6")
ability_grant("Block6")
ability_grant("Recolor")
//ability_grant("Hit24")
ability_grant("PlaceBomb")