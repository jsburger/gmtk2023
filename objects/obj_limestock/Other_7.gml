/// @description Insert description here
// You can write your code in this editor


image_index = 0
if sprite_index == sprLogoEnd {
	with instance_create_layer(x, y, layer, FadeTo) {
		destination = main_menu
	}
	image_alpha = 0
}
if sprite_index == sprLogoLoop {
	if loops > 0 {
		loops -= 1
	}
	else {
		sprite_index = sprLogoEnd
	}
}
if sprite_index = sprLogoStart {
	sprite_index = sprLogoLoop
}
