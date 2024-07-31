/// @description hiii obj_board
// You can write your code in this editor

//width = 600
//height = 700

//layer_script_begin("Instances", function() {
//	var cx = (board_left + board_right)/2,
//		cy = (board_top + board_bottom)/2;
//	matrix_stack_push(matrix_build(cx, cy, 0, 0, current_frame mod 360, 0, 1, 1, 1))
//	matrix_stack_push(matrix_build(-cx, -cy, -200, 0, 0, 0, 1, 1, 1))
//	matrix_set(matrix_world, matrix_stack_top())
//	matrix_stack_pop();
//	matrix_stack_pop();
//})
//layer_script_end("Instances", function() {
	
//	matrix_set(matrix_world, matrix_build_identity())
//})

#macro board_top obj_board.bbox_top
#macro board_bottom obj_board.bbox_bottom
#macro board_left obj_board.bbox_left
#macro board_right obj_board.bbox_right

#macro cam_x camera_get_view_x(view_camera[0])
#macro cam_y camera_get_view_y(view_camera[0])
#macro cam_width camera_get_view_width(view_camera[0])
#macro cam_height camera_get_view_height(view_camera[0])
#macro cam_center_x (cam_x + cam_width/2)
#macro cam_center_y (cam_y + cam_height/2)

become_active = false;
//Allows the shooter to act
active = false;

// Activates when clicked and not targeting
on_click = function() {
	if !active {
		become_active = 2
	}
}

// Takes priority over on_click when CombatRunner is targeting.
get_target_info = function() {
	return {
		type: TARGET_TYPE.BOARD
	}
}

//For drawing shadows
shadow_surface = -1;

editor = false;
canplace = true;
entity_num = 0;
entity_subnum = 0;
current_entity = BrickNormal;
current_sprite = mskNone;
obj_layer = 0;
entity_list = [
/*Bricks*/    [BrickNormal, BrickNormalV], [BrickGlow, BrickGlowV], [BrickLarge, BrickLargeV], [BrickLargeMetal, BrickLargeMetalV],
/*Movement 1*/[Bumper, ColorBumper],
/*Movement 2*/[Portal],
/*Movement 3*/[Launcher],
/*Explosives*/[BrickPipebomb, BrickPipebombV], [Bomb, ColorBomb],
/*Battler*/   [BattlerBrick]
];
entity_sprite = [
[sprBrick, sprBrickVertical], [sprBrickGlowOn, sprBrickGlowOnVertical], [sprBrickLarge, sprBrickLargeVertical], [sprBrickLargeMetal, sprBrickLargeMetalVertical],
[sprBumper, sprColorBumperIdle],
[sprPortalBackPurple],
[sprLauncher90],
[sprBrickPipebomb, sprBrickPipebombVertical], [sprBomb, sprColorBomb],
[sprEnemyFrame]
];

mx = 0;
my = 0;

enum editorMode {
	build,
	paint
}
mode = editorMode.build
paintcolor = -1

accept_objects_from = function(inst) {
	var last = array_last(entity_list),
		objects = inst.extra_objects;
	for (var i = 0; i < array_length(objects); i++) {
		if !array_contains(last, objects[i]) {
			array_push(last, objects[i])
			array_push(array_last(entity_sprite), object_get_sprite(objects[i]))
		}
	}
}