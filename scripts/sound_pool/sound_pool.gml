function sound_pool(soundName) {
	static cache = ds_map_create();
	
	if is_numeric(soundName) && asset_get_type(soundName) == asset_sound {
		soundName = audio_get_name(soundName)
		soundName = string_letters(soundName)
	}
	
	if ds_map_exists(cache, soundName) {
		return array_random(cache[? soundName]);
	}
	var a	= [],
		i	= 1,
		snd = soundName + string(i);
	
	while (asset_get_index(snd) != -1){
		array_push(a, asset_get_index(snd));
		snd = soundName + string(++i);
	}
	cache[? soundName] = a
	return sound_pool(soundName)
}