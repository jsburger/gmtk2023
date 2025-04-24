/// @description Lean

var leanMax = active ? 1 : 0,
	leanSpeed = .5;
if hovered {
	leanMax += 1
}

lean = lerp(lean, leanMax, .07)
if button_pressed(inputs.dash) encounter = encounter_get();