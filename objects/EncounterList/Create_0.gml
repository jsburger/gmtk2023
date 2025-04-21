/// @description 
// Get rid of normal encounter buttons. I'll clean them up later.
with EncounterButton y -= 1000;

var encounters = global.encounters;
for (var i = 0; i < array_length(global.encounters); i++) {
	var _y = 100 + 90 * floor(i/4),
		_x = 100 + 250 * (i mod 4);
	with instance_create_layer(_x, _y, "Instances", EncounterButton) {
		can_draw_enemy = true;
		encounter = global.encounters[i]
	}
}
