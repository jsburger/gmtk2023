/// @description 
var col = mana_get_color(color)
draw_self();
var pad = 2
draw_rectangle_color(bbox_left + pad, bbox_top + pad, bbox_right - pad - 16, bbox_bottom - pad, col, col, col, col, false);