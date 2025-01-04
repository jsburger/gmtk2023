
function stay_inside_board(use_bottom = true) {
	//Returns if the object went outside bounds
	if !instance_exists(Board) return false;
	var isMoving = abs(speed) > 0;
	var bounce = variable_instance_exists(self, "bounciness") ? self.bounciness : 1;
	var returnValue = false;
	
	if bbox_left < Board.bbox_left {
		if isMoving hspeed *= -bounce
		x += (Board.bbox_left - bbox_left)
		returnValue = true
	}
	if bbox_right > Board.bbox_right {
		if isMoving hspeed *= -bounce
		x += (Board.bbox_right - bbox_right)
		returnValue = true
	}
	
	if bbox_top < Board.bbox_top {
		if isMoving vspeed *= -bounce
		y += (Board.bbox_top - bbox_top)
		returnValue = true
	}

	if use_bottom && bbox_bottom > Board.bbox_bottom {
		if isMoving vspeed *= -bounce
		y += (Board.bbox_bottom - bbox_bottom)
		returnValue = true
	}
	
	return returnValue
}