global.player_stats = {
	character : new Character("Default"),
	hp: 50,
	throws_max: 1,
	throws: 1,
	spells: []
}
#macro Player global.player_stats

function player_get_hp() {
	if instance_exists(PlayerBattler) return PlayerBattler.hp;
	return global.player_stats.hp
}

/// Sets the player's current health, including its corresponding battler
function player_set_hp(n) {
	global.player_stats.hp = n;
	with PlayerBattler hp = n;
}

/// Give the player an spell. Accepts Spell instances or a String name
/// @param {Struct.Spell, String} spell
function spell_grant(spell) {
	if is_string(spell) spell = spell_get(spell)
	array_push(global.player_stats.spells, spell)
	
	with (SpellButtonHolder) {
		add_button(spell)
	}
}

//on_game_load(function() {
//	spell_grant(SPELLS.SLAMMY)
//	spell_grant(SPELLS.BLOCKO)
//	//spell_grant(SPELLS.REDIFY)
//	//spell_grant("Hit24")
//	spell_grant(SPELLS.PLACERS.BOMB)
//	spell_grant(SPELLS.PLACERS.BARREL)
//	spell_grant(SPELLS.REVIVE)
//	spell_grant(SPELLS.REDIFY)
//})