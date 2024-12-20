/// @description 

// Inherit the parent event
event_inherited();

brick_properties(function() {
	return new BrickHelper().vertical().large().statuses(true, true, true)
})

sprite_set = new SpriteSet(self, {
	spr_idle : sprite_index,
	spr_damaged : sprBrickLargeVerticalBroken
})
