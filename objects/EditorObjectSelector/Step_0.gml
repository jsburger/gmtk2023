/// @description 
mouse_found = false;
hovered = false

var list = Board.placers;
for (var i = 0; i < array_length(list); i++) {
	get_info(i);
	if hovered {
		if button_pressed(inputs.shoot) {
			if (Board.placer_index == i) {
				Board.current_placer().cycle(1)
			}
			else {
				Board.placer_index = i;				
			}
		}
		if button_pressed(inputs.dash) {
			list[i].cycle(-1);
		}
	}
}

if !button_check(inputs.editor_objects) {
	instance_destroy();
}