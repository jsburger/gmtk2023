/// @description 

spr_idle = sprSafetyNet;
spr_hurt = sprSafetyNetHurt;

deactivate = function() {
	fading = true;
	sprite_index = spr_hurt;
	var sound = sound_play_pitch(sndScream, .7)
	audio_sound_gain(sound, .25, 0)
	audio_sound_gain(sound, 0, 1000)
}

activate = function() {
	fading = false;
	sprite_index = spr_idle;
}

fading = true;
image_alpha = 0;