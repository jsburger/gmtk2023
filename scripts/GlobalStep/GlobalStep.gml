#macro sec * 60

global.step_source = time_source_create(time_source_game, 1, time_source_units_frames, global_step, [], -1, time_source_expire_nearest);
time_source_start(global.step_source)

global.currentFrame = 0;
#macro current_frame global.currentFrame

#macro trace show_debug_message
//Turns arguments into a local array named args
#macro arguments_pack var args = array_create(argument_count); for (var i = 0; i < argument_count; ++i) {args[i] = argument[i]}


global.font = font_add_sprite_ext(sprLimestockFontBig,
	".!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
	true, 2
)
draw_set_font(global.font)

#macro fntBig global.font
#macro fntSmall _fontLimestock
 

function global_step() {
	
	current_frame += 1;
	
	Clickables_Step()
	Tickables_Step()
	
	//static interface = new CombatInterface();
	//if keyboard_check_pressed(ord("B")) interface.apply_status(TARGETS.PLAYER, STATUS.POISON, 1)
}