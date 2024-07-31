/// @description 

var t = 1 - (time/time_max)
draw_set_alpha(t * .7);

gpu_set_blendmode(bm_add);

var dif = board_top - y;
draw_rectangle_color(x, y, x + 2 * TILE_MIN, y + dif * t,
	c_black, c_black, c_white, c_white, false)

gpu_set_blendmode(bm_normal);
draw_set_alpha(1);