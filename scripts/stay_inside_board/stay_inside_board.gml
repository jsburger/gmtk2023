// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function stay_inside_board() {
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
	//might not need this since the dice should handle landing on its own.
	//probably can just do that check first
	var _touchedBottom = false;
	if object_index == Ball || object_index == obj_ball{
		_touchedBottom = touchedBottom;
	}
	if bbox_bottom > Board.bbox_bottom && (_touchedBottom = false){
		if isMoving vspeed *= -bounce
		y += (Board.bbox_bottom - bbox_bottom)
		returnValue = true
	}
	
	return returnValue
}