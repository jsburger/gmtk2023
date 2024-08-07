/// @description 

// Inherit the parent event
event_inherited();

brick_properties(BrickNormalV, function() {
	return new BrickHelper().vertical().statuses();
})

replace_with_pipebomb(BrickNormalV, true)