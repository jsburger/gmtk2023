/// @description 

// Inherit the parent event
event_inherited();

set_hp(2)

brick_properties(function() {
	return new BrickHelper(true, false).statuses(true, true, true)
})

sprite_set = new SpriteSet(self, {
	spr_idle : sprite_index,
	spr_damaged : sprBrickLargeBroken
})

on_hurt = function(damage) {
	sprite_set.apply("spr_damaged")
}

mana_amount = 2;