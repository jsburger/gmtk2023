/// @description
var found = false;
if instance_exists(inspected) {
	inspected = noone;
	found = true;
}
if button_check(inputs.inspect) {
	with all if (variable_instance_exists(self, "inspect_text")) {
		if mouse_in_bbox(self) && position_meeting(mouse_x, mouse_y, self) {
			if array_length(inspect_text()) <= 0 continue;
			other.inspected = self;
			found = true;
		}
	}
	fade = max(fade, .3);
}

if found && fade < 1 {
	fade += .1 dt;
}
if !found && fade > 0 {
	fade -= .1 dt;
}