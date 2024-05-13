event_inherited();
sound_play_pitch(snd_explo, .7);
with (instance_create_depth(x, y, depth - 15, obj_color_explosion)) {
	color = other.color;	
}


with instance_create_layer(x, y, "Board", obj_stain_effect){
	depth -= 1;
	sprite_index = spr_splat_stain;
	switch other.color {
	case -1:
		image_blend = c_white
		break
	case MANA.RED:
		image_blend = #d12222
		break
	case MANA.BLUE:
		image_blend = #4566d1
		break
	case MANA.YELLOW:
		image_blend = #efc555
		break	
	}
}


scr_screenshake(10, 3, 0.2);