/// @description Move arm
event_inherited()
with arm {
	if image_angle != 0 {
		image_angle -= 5
	}
	x = other.x + other.arm_pos.x;
	y = other.y + other.arm_pos.y;
}