/// @description draw bg and frame
var scale = .75;
draw_sprite_ext(spr_portrait_bg, 0, x, y, scale, scale, 0, c_white, 1)
image_xscale = scale;
image_yscale = scale;
draw_self()
image_xscale = 1;
image_yscale = 1;
draw_sprite_ext(spr_portrait_frame, 0, x, y, scale, scale, 0, c_white, 1)
