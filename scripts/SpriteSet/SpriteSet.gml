function SpriteSet(_owner, _sprites) constructor {
	sprites = _sprites;
	
	last_sprite = undefined;
	owner = _owner;
	
	for (var i = 0, names = struct_get_names(sprites); i < array_length(names); i++) {
		var name = names[i],
			value = struct_get(sprites, name);
		if value == owner.sprite_index {
			last_sprite = name;
			break;
		}
	}
	
	static apply = function(name) {
		var sprite = struct_get(sprites, name);
		if instance_is(owner, parBoardObject) && owner.is_burning {
			sprite = burn_sprite_get(sprite);
		}
		owner.sprite_index = sprite;
		last_sprite = name;
	}
	
	static refresh = function() {
		if last_sprite != undefined {
			apply(last_sprite);
		}
	}
}