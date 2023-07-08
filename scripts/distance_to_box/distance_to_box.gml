
function distance_to_box(_x, _y, x1, y1, x2, y2) {
	return point_distance(clamp(_x, x1, x2), clamp(_y, y1, y2), _x, _y)
}

function distance_to_bbox(_x, _y, inst) {
	return distance_to_box(_x, _y, inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom)
}

function direction_to_box(_x, _y, x1, y1, x2, y2) {
	return point_direction(_x, _y, clamp(_x, x1, x2), clamp(_y, y1, y2))
}

function direction_to_bbox(_x, _y, inst) {
	return direction_to_box(_x, _y, inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom)
}

function point_in_bbox(_x, _y, inst) {
	return point_in_rectangle(_x, _y, inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom)
}

function in_range(n, _min, _max) {
	return n >= _min && n <= _max
}
/// @desc In range (exclusive)
function in_range_exc(n, _min, _max) {
	return n > _min && n < _max
}