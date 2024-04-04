randomize();
var w = 1600, h = 900
window_set_size(w, h)
surface_resize(application_surface, w, h)
camera_set_view_size(view_camera[0], w, h)
var x_origin = (1168 - w)/2 - 168
camera_set_view_pos(view_camera[0], x_origin, 0)
window_center()