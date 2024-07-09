event_inherited();
sound_play_pitch(snd_explo, .7);
instance_create_depth(x, y, depth - 15, obj_explosion_radius);

with instance_create_layer(x, y, "Board", obj_stain_effect){
	depth -= 1;
	sprite_index = sprFXExplosionMarkSmall;
	image_index = random(image_number);
}


scr_screenshake(10, 3, 0.2);