/// @description Creates Tokens!!!

// Inherit the parent event
event_inherited();

for(var i = 0; i < 3; i++) {
	with instance_create_layer(x, y - 8, "Projectiles", ManaToken){
		motion_set(random_range(60, 120), 5);
		set_color(i);
	}
}

with instance_create_layer(x, y, "FX", obj_fx) {
	sprite_index = sprFXSphere
}

sound_play(sndBrickCashHit)