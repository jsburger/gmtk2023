/// @param {Struct.EditorPlacer, Asset.GMObject} placer
function PlacerSpell(_placer) : Spell() constructor {
	if is_struct(_placer) {
		placer = _placer;
	}
	else {
		placer = new SingleObjectPlacer(_placer);
	}
	placer.line_enabled = false;
	placer.admin = false;
	
	static on_click = function() {
		if placer.on_click() {
			cast();
		}
	}
	static on_hold = function(last_x, last_y) { placer.on_hold(last_x, last_y); }
	static on_release = function() { placer.on_release(); }
	
	static clear = function() { placer.reset(); }
	
	static active_draw = function() { placer.draw_world(); }
	
	static active_step = function() {
		var rotate = button_pressed(inputs.turn_right) - button_pressed(inputs.turn_left);
		if rotate != 0 {
			placer.cycle(rotate);
		}
	}
}