/// @description 

// Inherit the parent event
event_inherited();
brick_properties(function() {
	return new BrickHelper().statuses();
})

if is_this {
	on_level_placement.add_layer(function() {
		replace_with_pipebomb()
	})
}