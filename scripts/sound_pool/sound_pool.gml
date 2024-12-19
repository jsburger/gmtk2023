function sound_pool(soundName) {
	static cache = ds_map_create();
	static nameCache = new FunctionCache(function(input) {
		return string_letters(audio_get_name(input));
	})
	
	if is_numeric(soundName) && asset_get_type(soundName) == asset_sound {
		soundName = nameCache.get(soundName)
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