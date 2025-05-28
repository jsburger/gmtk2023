/// @description Lean

var cast = spell.can_cast();
var leanMax = active ? 1 : 0;

if hovered {
	leanMax = 1
	//if !cast leanMax -= .3
	if playSound && cast {
		sound_play_pitch(sndButton, random_range(0.9, 1.1))
		playSound = false;
	}
}
else {
	playSound = true;	
}

//if !cast leanMax -= .4

lean = lerp(lean, leanMax, .5)

if (hovered || active) && spell != undefined {
	var costs = spell.costs;
	for (var i = 0; i < array_length(costs); i++) {
		if costs[i] > 0 {
			with ManaDrawer blink[i] = .6;
		}
	}
}