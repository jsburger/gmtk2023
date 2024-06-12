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