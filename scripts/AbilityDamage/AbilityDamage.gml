register_ability("hit10", function() {
	with new AbilityAttack(10) {
		set_costs(0, 0, 0)
		name = "Slammy"
		desc = "Deal 10 damage to targeted enemy"
		sprite_index = sprIntentAttack		
		return self
	}
})