/// @description Explode
sound_play_pitch(sndExplosion, .7);
instance_create_depth(x, y, depth - 15, obj_explosion_radius);

with instance_create_layer(x, y, "Board", BombStain) {
	depth -= 1;
	sprite_index = sprFXExplosionMarkSmall;
	shuffle;
}

scr_screenshake(10, 3, 0.2);