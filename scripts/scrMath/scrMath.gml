/// Returns a random frame of a sprite
function image_random(sprite) {
	return irandom(sprite_get_number(sprite) - 1)
}

function anglefy(n) {
	while n < 0 n += 360;
	while n > 0 n -= 360;
	return n;
}