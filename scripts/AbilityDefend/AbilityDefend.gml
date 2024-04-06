register_ability("Block6", function() {
	with new AbilityDefend(6) {
		set_costs(8, 0, 0)
		name = "Blocko"
		desc = "Gain 6 Block"
		sprite_index = sprIntentDefend		
		return self
	}
})