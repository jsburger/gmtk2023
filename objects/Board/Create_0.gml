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

#macro board_top Board.bbox_top
#macro board_bottom Board.bbox_bottom
#macro board_left Board.bbox_left
#macro board_right Board.bbox_right

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

hovered = false;
// Activates when clicked and not targeting
on_click = function() {
	if !active {
		become_active = 2
	}
}

//For drawing shadows
shadow_surface = -1;

splat_surface = undefined;
splat_start = function() {
	surface_set_target(splat_surface);
	matrix_set(matrix_world, matrix_build(-cam_x, -cam_y, 0, 0, 0, 0, 1, 1, 1))
}
splat_end = function() {
	surface_reset_target();
	matrix_set(matrix_world, matrix_build_identity())
}

marker_surface = undefined;
marker_x = mouse_x;
marker_y = mouse_y;

marker_draw = function(x, y, col, size) {
	matrix_set(matrix_world, matrix_build(-cam_x, -cam_y, 0, 0, 0, 0, 1, 1, 1))
	surface_set_target(marker_surface);
	draw_circle_color(marker_x, marker_y, size, col, col, false);
	draw_line_width_color(marker_x, marker_y, x, y, 2 * size, col, col);
	draw_circle_color(x, y, size, col, col, false);
	surface_reset_target();
	matrix_set(matrix_world, matrix_build_identity())
	
	marker_x = x;
	marker_y = y;
}

marker_color_index = COLORS.RED;

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
/*Bricks*/    [BrickNormal, BrickNormalV, PegSmall], [BrickLarge, BrickLargeV, PegNormal], [BrickGlow, BrickGlowV], [BrickLargeGlow, BrickLargeGlowV], [BrickLargeMetal, BrickLargeMetalV],
			  [BrickMetal, BrickMetalXL, PegMetal], [BrickHidden, BrickHiddenV], [BrickLargeHidden, BrickLargeHiddenV],
			  new RotatingPlacer(OneWayBrick, 90),
/*Movement 1*/[Bumper, ColorBumper],
/*Movement 2*/ new PortalPlacer(),
/*Movement 3*/ new LauncherPlacer(Launcher),
			   new LauncherPlacer(Barrel),
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