/// Returns a random frame of a sprite
function image_random(sprite) {
	return irandom(sprite_get_number(sprite) - 1)
}

function anglefy(n) {
	while n < 0 n += 360;
	while n > 0 n -= 360;
	return n;
}

/// Max is exclusive, Min is inclusive
function wrap(n, _min, _max) {
	var range = _max - _min;
	if n < _min {
		return _max - (_min - n) mod range;
	}
	return _min + (n - _min) mod range;
}