function sound_pool(soundName){
	static cache = ds_map_create();
	if ds_map_exists(cache, soundName) {
		return array_random(cache[? soundName])
	}
	var a = []
	var i = 1
	var snd = soundName + (i >= 10 ? string(i) : ("0" + string(i)))
	while (asset_get_index(snd) != -1){
		array_push(a, asset_get_index(snd))
		i++
		snd = soundName + (i >= 10 ? string(i) : ("0" + string(i)))
	}
	cache[? soundName] = a
	return sound_pool(soundName)
}