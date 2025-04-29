global.player_stats = {
	hp: 50,
	throws_max: 1,
	throws: 1,
	abilities: []
}

function player_get_hp() {
	if instance_exists(PlayerBattler) return PlayerBattler.hp;
	return global.player_stats.hp
}

/// Sets the player's current health, including its corresponding battler
function player_set_hp(n) {
	global.player_stats.hp = n;
	with PlayerBattler hp = n;
}


/// Give the player an ability. Accepts Ability instances or a String name
/// @param {Struct.Ability, String} ability
function ability_grant(ability) {
	if is_string(ability) ability = ability_get(ability)
	array_push(global.player_stats.abilities, ability)
	
	with (AbilityButtonHolder) {
		add_button(ability)
	}
}

on_game_load(function() {
	ability_grant(SPELLS.SLAMMY)
	ability_grant(SPELLS.BLOCKO)
	ability_grant(SPELLS.REDIFY)
	//ability_grant("Hit24")
	ability_grant(SPELLS.PLACE_BOMB)
	ability_grant(SPELLS.PLACE_BARREL)
})