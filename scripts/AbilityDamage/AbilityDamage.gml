register_ability("Hit6", function() {
	with new AbilityAttack(6) {
		set_costs(0, 8, 0);
		set_uses(2);
		name = "Slammy"
		desc = "Deal 6 damage to targeted enemy"
		sprite_index = sprIntentAttack		
		return self
	}
})

register_ability("Hit24", function() {
	with new AbilityAttack(24) {
		set_uses(2);
		set_costs(0, 16, 8)
		name = "Slammy Senior"
		desc = "Deal 24 damage to targeted enemy"
		sprite_index = sprIntentAttack
		return self
	}
})

register_ability("Recolor", function() {
	with new Ability(TARGET_TYPE.NONE) {
		name = "Redify"
		desc = "Redify 8 bricks"
		set_costs(3, 0, 1)
		sprite_index = sprPortraitBg
		image_xscale = .35
		image_yscale = .35
		set_targets(TARGET_TYPE.NONE)
		
		act = function(runner) {
			recolor(8, COLORS.RED)
		}
		
		return self;
	}
	
})

