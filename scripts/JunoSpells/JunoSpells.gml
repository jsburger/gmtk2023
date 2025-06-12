/// @ignore
// JunoCharacter() <= middle click for quick access
function get_juno_spells() {
	var a = {};
	a.PLACERS = {};
	var p = a.PLACERS;
	p.PROBE = register_spell("PlaceProbe", function() {
		with new PlacerSpell(JunoProbe) {
			name = "Probe";
			desc = "Place an explosive probe which your Active Ability will target.";
			set_costs(8, 4, 0);
			sprite_index = sprJunoProbe;
		}
	})
	
	
	return a;
}