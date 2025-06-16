/// @description Decrement lifespan

life -= 1 dt;
if life <= 0 {
	instance_destroy()
	room_goto(destination)
}