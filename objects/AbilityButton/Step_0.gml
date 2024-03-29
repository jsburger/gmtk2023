/// @description Lean

var leanMax = active ? 1 : 0,
	leanSpeed = .5;
if point_in_bbox(mouse_x, mouse_y, self) {
	leanMax += 1
}

lean = lerp(lean, leanMax, .07)