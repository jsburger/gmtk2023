global.step_source = time_source_create(time_source_game, 1, time_source_units_frames, global_step, [], -1, time_source_expire_nearest);
time_source_start(global.step_source)

function global_step() {
	
	Clickables_Step()
	
}