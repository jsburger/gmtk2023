// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function is_outside_board(){
	if !instance_exists(Board) return false
	
	if bbox_left < Board.bbox_left {
		return true
	}
	if bbox_right > Board.bbox_right {
		return true
	}
	if bbox_top < Board.bbox_top {
		return true
	}
	if bbox_bottom > Board.bbox_bottom {
		return true
	}
}