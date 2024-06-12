// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//function schedule(_delay, _function){
//	ds_list_add(gamecont.delays, {time: _delay, func: _function})
//}

//global.scheduling_source = time_source_create_parent(time_source_game);

function schedule(frames, callback, args = []) {
	var source = time_source_create(time_source_game, floor(frames), time_source_units_frames, callback, args);
	time_source_start(source);
	return source;
}
function schedule_raw(frames, callback) {
	var source = time_source_create(time_source_global, floor(frames), time_source_units_frames, callback);
	time_source_start(source);
	return source;
}

//function time_source_create_parent(parentsource) {
//	var source = time_source_create(parentsource, 1000000000000000, time_source_units_seconds, nothing, [], -1);
//	time_source_start(source)
//	return source;
//}
//function nothing() {}