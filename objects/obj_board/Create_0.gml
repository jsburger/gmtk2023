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
#macro cam_right (cam_x + cam_width)
#macro cam_bottom (cam_y + cam_height)

#macro TILE_WIDTH 32
#macro TILE_HEIGHT 16
#macro TILE_MIN 16

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


clicked = false;
clicked_x = 0;
clicked_y = 0;

right_clicked = false;
right_clicked_x = 0;
right_clicked_y = 0;


entity_list = [
/*Bricks*/    [BrickNormal, BrickNormalV], [BrickLarge, BrickLargeV], [BrickGlow, BrickGlowV], [BrickLargeGlow, BrickLargeGlowV], [BrickLargeMetal, BrickLargeMetalV],
			  [BrickMetal, BrickMetalXL], [BrickHidden, BrickHiddenV], [BrickLargeHidden, BrickLargeHiddenV],
			  new RotatingPlacer(OneWayBrick, 90),
/*Movement 1*/[Bumper, ColorBumper],
/*Movement 2*/ new PortalPlacer(),
/*Movement 3*/ new LauncherPlacer(),
/*Explosives*/[BrickPipebomb, BrickPipebombV], [Bomb, ColorBomb],
/*Other*/     [Token],
/*Battler*/   [BattlerBrick], [BattlerBrickSmall]
];

process_object = function(obj) {
	if !is_struct(obj) {
		return new ObjectPlacer(obj)
	}
	else {
		return obj
	}
}

placers = [];
placer_index = 0;
for (var i = 0; i < array_length(entity_list); i++) {
	placers[i] = process_object(entity_list[i])
}

current_placer = function() {
	return placers[placer_index]
}

accepted_enemies = [];

mx = 0;
my = 0;

enum editorMode {
	build,
	paint
}
mode = editorMode.build
paintcolor = -1

enter_paint_mode = function(col = undefined) {
	with BoardPaintButton activate();
	
	mode = editorMode.paint;
	if col != undefined {
		paintcolor = col;
	}
	
	with BoardPaintSubButton {
		deactivate();
		if color == other.paintcolor activate();
	}
}
exit_paint_mode = function() {
	with BoardPaintButton {
		deactivate();
	}
	with BoardPaintSubButton deactivate();
	mode = editorMode.build;
}

accept_objects_from = function(inst) {
	
	if !(array_contains(accepted_enemies, inst.object_index)) {
		var objects = inst.extra_objects;
		if array_length(objects) <= 0 exit;
		
		array_push(accepted_enemies, inst.object_index);
		array_push(placers, process_object(objects))
		//array_push(entity_sprite, array_map(objects, object_get_sprite))
	}
}