register_ability("Hit6", function() {
	with new AbilityAttack(69) {
		set_costs(0, 0, 0)
		name = "Slammy"
		desc = "Deal 6 damage to targeted enemy"
		sprite_index = sprIntentAttack		
		return self
	}
})

register_ability("Hit24", function() {
	with new AbilityAttack(24) {
		set_costs(0, 16, 8)
		name = "Slammy Senior"
		desc = "Deal 24 damage to targeted enemy"
		sprite_index = sprIntentAttack
		return self
	}
})

