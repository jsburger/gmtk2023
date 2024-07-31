/// @description Background editor grid
// You can write your code in this editor
var size = (32/96);
draw_sprite_ext(sprBoardBg, 0, x, y, (image_xscale) * size, (image_yscale) * size, image_angle, image_blend, image_alpha)
draw_self();
draw_sprite_ext(sprBoardBorder, 0, x, y, 1, 1, image_angle, image_blend, image_alpha)

//board_can_fit(obj_bomb, mouse_x, mouse_y)

//Editor grid
if(editor){
	
	var _c = c_black,
	    _w = 1,
		_a = 1;
	//Vertical lines
	var width = floor((bbox_right - bbox_left)/TILE_MIN) - 2;
	for(var i = 0; i <= width; i++){
		_c = (i == round(width/4) || i == round(width * 3/4)) ? c_navy : (i == round(width/2) ? c_blue : c_black);
		_w = (_c != c_black || i == 0 || i == width) ? 2 : 1;
		_a = i mod 2 != 0 && _c == c_black ? .3 : .6;
		draw_set_alpha(_a);
		draw_line_width_color(
						bbox_left + TILE_MIN * (i + 1), 
						bbox_top + TILE_MIN, 
						bbox_left + TILE_MIN * (i + 1), 
						bbox_bottom - TILE_MIN,
						_w, _c, _c);
	}
	//Horizontal lines
	var height = floor((bbox_bottom - bbox_top)/TILE_MIN) - 2;
	for(var i = 0; i <= height; i++){
		_c = (i == round(height/4) || i == round(height * 3/4)) ? c_maroon : (i == round(height/2) ? c_red : c_black);
		_w = (_c != c_black || i == 0 || i == height) ? 2 : 1;
		_a = i mod 2 != 0 && _c == c_black ? .3 : .6;
		draw_set_alpha(_a);
		draw_line_width_color(
						bbox_left + TILE_MIN,
						bbox_top + TILE_MIN * (i + 1),
						bbox_right - TILE_MIN,
						bbox_top + TILE_MIN * (i + 1),
						_w, _c, _c);
	}
	draw_set_alpha(1);
}

if !surface_exists(shadow_surface) {
	shadow_surface = surface_create(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));	
}

var surface = shadow_surface
var camera_x = camera_get_view_x(view_camera[0]) 
var camera_y = camera_get_view_y(view_camera[0])

surface_set_target(surface)
draw_clear_alpha(c_black,0);
gpu_set_fog(true, c_white, 0, 0)


matrix_set(matrix_world, matrix_build(-camera_x, -camera_y, 0, 0, 0, 0, 1, 1, 1))

with par_collectible {
	draw_self()
}

with Ball {
	draw_self()
}

with parBoardObject {
	if visible {
		event_perform(ev_draw, ev_draw_normal)
	}
}


matrix_set(matrix_world, matrix_build_identity())

//with Gibs {
//	x -= camera_x;
//	y -= camera_y;
	
//	draw_self()
	
//	x += camera_x;
//	y += camera_y;
//}

surface_reset_target()
gpu_set_fog(false, c_black, 0, 0)

draw_surface_ext(surface, camera_x + 4, camera_y + 4, 1, 1, 0, c_black, 0.8)