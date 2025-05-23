on_board_clear(function() {
	with Board surface_clear(marker_surface);
})

function surface_clear(surface) {
	surface_set_target(surface);
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
}