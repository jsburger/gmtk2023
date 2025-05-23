
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

/// @desc n >= _min && n <= _max
function in_range(n, _min, _max) {
	return n >= _min && n <= _max
}
/// @desc In range (exclusive)
function in_range_exc(n, _min, _max) {
	return n > _min && n < _max
}

function mouse_in_rectangle(x1, y1, x2, y2) {
	return point_in_rectangle(mouse_x, mouse_y, x1, y1, x2, y2)
}

function mouse_in_bbox(inst) {
	gml_pragma("forceinline");
	return point_in_bbox(mouse_x, mouse_y, inst);
}

function point_distance_struct(a, b) {
	return point_distance(a.x, a.y, b.x, b.y);
}
function point_direction_struct(a, b) {
	return point_direction(a.x, a.y, b.x, b.y);
}