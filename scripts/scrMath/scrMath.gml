/// Returns a random frame of a sprite
function image_random(sprite) {
	return irandom(sprite_get_number(sprite) - 1)
}