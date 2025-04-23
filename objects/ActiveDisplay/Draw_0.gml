/// @description 
if instance_exists(Shooter) {
	var start_angle = 0;
	for (var i = Shooter.active_charges; i > 0; i--) {
		draw_sprite_ext(sprChip, 0,
			x + lengthdir_x(100, start_angle + 25 * i),
			y + lengthdir_y(100, start_angle + 25 * i),
			1.5, 1.5, 0, c_white, 1
		)
	}
}