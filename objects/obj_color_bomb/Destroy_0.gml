event_inherited();
sound_play_pitch(snd_explo, .7);
with (instance_create_depth(x, y, depth - 15, obj_color_explosion)) {
	color = other.color;	
}


with instance_create_layer(x, y, "Board", obj_stain_effect){
	depth -= 1;
	sprite_index = sprFXSplatStain;
	image_blend = mana_get_color(other.color);
}


scr_screenshake(10, 3, 0.2);