global.step_source = time_source_create(time_source_game, 1, time_source_units_frames, global_step, [], -1, time_source_expire_nearest);
time_source_start(global.step_source)

global.currentFrame = 0;
#macro current_frame global.currentFrame

#macro trace show_debug_message


function global_step() {
	
	current_frame += 1;
	
	Clickables_Step()
	
}