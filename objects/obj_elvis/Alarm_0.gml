/// @description Chatter
exit
{
	if !elvis_is_speaking() && !instance_exists(FadeTo) && irandom(2) != 0 {
		var _snd = sound_pool("voChatter");

		if !irandom(50) _snd = sound_pool("voChatterRare");
		say_line(_snd, -1, false);
	}
	alarm[0] = game_get_speed(gamespeed_fps) * random_range(20, 45);
}