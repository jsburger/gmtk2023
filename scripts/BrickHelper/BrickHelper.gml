function BrickHelper(_large = false, _vertical = false) constructor {
	is_large = _large;
	is_vertical = _vertical;
	
	can_freeze = false;
	can_burn = false;
	can_poison = false;
	
	
	///@returns {Struct.BrickHelper}
	static large = function(value = true) {
		is_large = value;
		return self;
	}
	
	///@returns {Struct.BrickHelper}
	static vertical = function(value = true) {
		is_vertical = value;
		return self;
	}
	
	///@returns {Struct.BrickHelper}
	static freeze = function(value = true) {
		can_freeze = value;
		return self;
	}
	///@returns {Struct.BrickHelper}
	static burn = function(value = true) {
		can_burn = value;
		return self;
	}
	///@returns {Struct.BrickHelper}
	static poison = function(value = true) {
		can_poison = value;
		return self;
	}
	///@returns {Struct.BrickHelper}
	static statuses = function(_freeze = true, _burn = true, _poison = true) {
		freeze(_freeze);
		burn(_burn);
		poison(_poison);
		return self;
	}
	
	
	static apply = function(brick) {
		if can_freeze {
			var overlay = freeze_overlay_get(is_large, is_vertical);
			brick.setup_freeze(overlay);			
		}
		if can_poison {
			brick.setup_poison(poison_overlay_get(is_large, is_vertical))
		}
		if can_burn {
			brick.can_burn = true;
		}
	}
	
}

function brick_properties(object, properties_factory) {
	static map = ds_map_create();
	
	if !ds_map_exists(map, object) {
		ds_map_set(map, object, properties_factory())
	}
	if object_index != object exit;
	
	var properties = map[? object];
	properties.apply(self)
}


function freeze_overlay_get(is_large = false, is_vertical = false) {
	if is_large {
		if is_vertical return sprBrickLargeVerticalFrozen;
		return sprBrickLargeOverlayFrozen;
	}
	else {
		if is_vertical return sprBrickVerticalFrozen;
		return sprBrickFrozen;
	}
}

function poison_overlay_get(is_large = false, is_vertical = false) {
	if is_large {
		if is_vertical return sprPoisonOverlayLargeVertical;
		return sprPoisonOverlayLarge;
	}
	else {
		if is_vertical return sprPoisonOverlayVertical;
		return sprPoisonOverlay;
	}
}

/// @returns {Asset.GMSprite}
function burn_sprite_get(sprite) {
	var name = sprite_get_name(sprite),
		asset = asset_get_index(name + "Burnt");
	if asset != -1 return asset;
	return sprite
}