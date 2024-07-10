/// @description Lean

var cast = ability.can_cast();
var leanMax = active ? 1 : 0;

if point_in_bbox(mouse_x, mouse_y, self) {
	leanMax += .5
	if !cast leanMax -= .3
}
if !cast leanMax -= .4

lean = lerp(lean, leanMax, .07)