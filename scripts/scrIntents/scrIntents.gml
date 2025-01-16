enum INTENT {
	ATTACK,
	BLOCK,
	DEBUFF,
	MISC
}

function intent_get_icon(intent) {
	static sprites = [sprIntentAttack, sprIntentDefend, sprIntentDebuff, sprIntentMisc]
	
	return sprites[intent];
}

function intent_draw(_x, _y, intent, value) {
	var sprite = intent_get_icon(intent);
	
	draw_sprite(sprite, sprite_get_animation_frame(sprite), _x, _y)
	if value != undefined {
		draw_text(_x + 24, _y + 24, string(value))
	}
	
}

function Intent(sprite, value = undefined) constructor {
	height = 72;
	self.value = value;
	desc = "Default Description"
	sprite_index = sprite;
	
	backdrop = undefined;
	/// @param {Struct.Sprite, Asset.GMSprite} sprite
	static with_backdrop = function(sprite) {
		if !is_instanceof(sprite, Sprite) sprite = new Sprite(sprite);
		backdrop = sprite;
		return self;
	}
	
	///@param {Struct.Formatter, String} _desc
	static with_desc = function(_desc) {
		desc = _desc;
		return self;
	}
	
	static draw_value = function(draw_x, draw_y) {
		if (value != undefined) {
			draw_text(draw_x + 24, draw_y + 24, string(value));
		}
	}
	
	static draw = function(draw_x, draw_y, hovered) {
		if backdrop != undefined backdrop.draw(draw_x, draw_y);
		if is_instanceof(sprite_index, Sprite) {
			sprite_index.draw(draw_x, draw_y);
		}
		else {
			draw_sprite_auto(sprite_index, draw_x, draw_y);
		}
		draw_value(draw_x, draw_y);
		
		if hovered {
			draw_textbox(draw_x - 64, draw_y - 48, desc)
		}
	}
}

function RecolorIntent(amount, color) : Intent(sprIntentRecolor, amount) constructor {
	sprite_index = new ColoredSprite(color, sprIntentRecolor)
	if is_method(color) || is_provider(color) {
		color = new ColorNameProvider(color);
	}
	else {
		color = color_get_name(color);
	}
	desc = format("Recolor {0} bricks {1}.", amount, color);
}