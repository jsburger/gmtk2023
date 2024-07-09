/// @description draw bg and frame
draw_sprite_ext(sprEnemyBg, 0, x, y, image_xscale, image_yscale, 0, bg_color, show_owner ? .8 : .25)
if show_owner show_owner = false
draw_self()
draw_sprite_ext(sprEnemyFrame, 0, x, y, image_xscale, image_yscale, 0, c_white, 1)
