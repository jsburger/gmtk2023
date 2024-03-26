/// @description Lean

var leanMax = active ? 1 : 0,
	leanSpeed = .04;
if point_in_bbox(mouse_x, mouse_y, self) {
	leanMax += .3
}

lean = lerp(lean, leanMax, .07)