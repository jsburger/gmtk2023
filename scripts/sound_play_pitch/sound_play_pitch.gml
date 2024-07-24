// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sound_play_pitch(sound, pitch){
	//audio_stop_sound(sound);
	var snd = audio_play_sound(sound, 1, 0);
	audio_sound_pitch(snd, pitch);
	return snd;
}

/// Plays sound at base pitch * (80-120%)
function sound_play_random(sound, base_pitch = 1) {
	return sound_play_pitch(sound, base_pitch * random_range(.8, 1.2))
}

function sound_play(sound) {
	return audio_play_sound(sound, 1, 0)
}