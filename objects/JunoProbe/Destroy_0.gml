/// @description 
sound_play_random(sndExplosion);

explode(new Explosion(x, y, self, explosion_size, explosion_damage));

with instance_create_layer(x, y, "Board", BombStain) {
	sprite_index = sprFXExplosionMarkSmall;
	shuffle;
	depth -= 1;
}
with instance_create_layer(x, y, "FX", obj_fx) {
	sprite_index = sprFXExplosionRadius;
	image_angle = 0;
}
scr_screenshake(8, 3, 0.2);