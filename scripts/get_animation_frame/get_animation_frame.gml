function get_animation_frame(framecount, _fps = 10) {
	// f/s / animation/s = frames per animation frame
	var n = 60 / _fps;
	return (time_to_frame() / n) mod framecount;
}

function time_to_frame() {
	//1000 ms/s / f/s = ms per game frame
	static n = 1000/60;
	return round(current_time / n);
}

function sprite_get_animation_frame(sprite) {
	if sprite_get_number(sprite) == 1 return 0;
	return get_animation_frame(sprite_get_number(sprite), sprite_get_speed(sprite))
}

/// @param {Asset.GMSprite,Struct.Sprite} sprite
function draw_sprite_auto(sprite, x, y) {
	if is_struct(sprite) && is_instanceof(sprite, Sprite) {
		sprite.draw(x, y);
	}
	else {
		draw_sprite(sprite, sprite_get_animation_frame(sprite), x, y);
	}
}