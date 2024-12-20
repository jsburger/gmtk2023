/// @description Insert description here
// You can write your code in this editor
var a = image_alpha;
if Board.obj_layer != obj_layer && Board.editor image_alpha = .5;
draw_self();
image_alpha = a;

if blocking{
	if Board.obj_layer == obj_layer{
		draw_set_alpha(.35);
		draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, c_red, c_red, c_red, false);
		draw_set_alpha(1);
	
		//gpu_set_fog(true, c_red, 0, 0);
		//draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, .5);
		//gpu_set_fog(false, c_red, 0, 0);
	}
}