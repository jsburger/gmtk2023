function Sprite(sprite) constructor {
	sprite_index = sprite;
	image_xscale = 1;
	image_yscale = 1;
	image_blend = c_white;
	image_alpha = 1;
	image_angle = 0;
	x = 0;
	y = 0;

	static get_color = function() {
		return image_blend;
	}


	static draw = function(draw_x, draw_y) {
		draw_sprite_ext(sprite_index, sprite_get_animation_frame(sprite_index), draw_x + x, draw_y + y,
		image_xscale, image_yscale, image_angle, get_color(), image_alpha)
	}
	
	static scale = function(xscale, yscale = xscale) {
		image_xscale = xscale;
		image_yscale = yscale;
		return self;
	}
	static with_color = function(color) {
		image_blend = color;
		return self;
	}
}

function ColoredSprite(color, sprite) : Sprite(sprite) constructor {
	self.color = color;
	
	static get_color = function() {
		if image_blend == c_white {
			return mana_get_color(provider_get(color));
		}
		return color_multiply(mana_get_color(provider_get(color)), image_blend);
	}
}

/// @desc Does simple RGB multiplication, should be the same as image_blend.
function color_multiply(a, b) {
	var red = (color_get_red(a) * color_get_red(b))/255,
		blue = (color_get_blue(a) * color_get_blue(b))/255,
		green = (color_get_green(a) * color_get_green(b))/255;
	return make_color_rgb(red, green, blue);
}