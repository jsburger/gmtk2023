event_inherited();
sound_play_pitch(snd_explo, .7);
instance_create_depth(x, y, depth - 15, obj_explosion_radius);

scr_screenshake(10, 3, 0.2);