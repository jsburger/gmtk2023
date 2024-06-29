/// @description 

if sprite_index == sprSentientSymbolTransform {
	switch(form) {
		case MANA.RED :
			sprite_index = sprSentientSymbolIdleRed;
			spr_icon = sprSentientSymbolIconRed;
			break;
		case MANA.BLUE:
			sprite_index = sprSentientSymbolIdleBlue;
			spr_icon = sprSentientSymbolIconBlue;
			break;
		case MANA.YELLOW:
			sprite_index = sprSentientSymbolIdleYellow;
			spr_icon = sprSentientSymbolIconYellow;
			break;
	}
	image_index = 0
}