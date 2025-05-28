function InstantSpell() : Spell() constructor {
	is_instant = true;
}

/// @param {Real,Struct.Provider,Function} amount
function BlockSpell(amount) : InstantSpell() constructor {
	block_amount = amount
	static act = function() {
		defend(TARGETS.PLAYER, block_amount)
	}
}