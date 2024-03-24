function scr_screenshake(_time, _magnitute, _fade)
{
	with (obj_screenshake)
	{
		shake = true;
		shake_time = _time;
		shake_magnitude = _magnitute;
		shake_fade = _fade;
	}
}