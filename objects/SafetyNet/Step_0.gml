/// @description 

if instance_exists(Ball) {
	x = Ball.x;
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