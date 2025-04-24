/// @description 

if instance_exists(PlayerBall) {
	x = PlayerBall.x;
}
else if instance_exists(Shooter) {
	x = Shooter.x;
}
var s = .05;
if fading && image_alpha > 0 {
	image_alpha -= s;
}
if !fading && image_alpha < 1 {
	image_alpha += s;
}
if SMART_NET {
	image_angle = angle_difference(point_direction(x, y, mouse_x, mouse_y), 90)/3;
}