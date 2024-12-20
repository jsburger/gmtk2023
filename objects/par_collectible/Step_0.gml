/// @description Move Towards Player
// You can write your code in this editor

if instance_exists(Shooter) {
	if distance_to_object(Shooter) < 26 {
		move_towards_point(Shooter.x, Shooter.y, 6)
	}
}


