/// Returns if the player is currently throwing the ball
// Here so logic is easier to update later
function throw_active(){
	return instance_exists(Ball);
}