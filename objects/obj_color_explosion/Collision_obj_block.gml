/// @description Insert description here
// You can write your code in this editor

if other.colorable {		
	switch color {
		case -1:
			other.image_blend = c_white
			other.color = -1;
			break
		case MANA.RED:
			other.image_blend = #d12222
			other.color = MANA.RED
			break
		case MANA.BLUE:
			other.image_blend = #4566d1
			other.color = MANA.BLUE
			break
		case MANA.YELLOW:
			other.image_blend = #efc555
			other.color = MANA.YELLOW
			break
	}		
}