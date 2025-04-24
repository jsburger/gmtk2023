/// @ignore
function gather_hoverables() {
	static last_inst = noone;
	
	var tester = {
		depth : infinity,
		inst : noone,
		test : function (item, x1, y1, x2, y2, _depth) {
			if (_depth < depth) && mouse_in_rectangle(x1, y1, x2, y2) {
				inst = item;
				depth = _depth;
			}
		},
		test_box : function(item, x, y, range, _depth) {
			test(item, x - range, y - range, x + range, y + range, _depth);
		}
	}
	
	var clickables = global.clickable_objects.instances();
	for (var i = 0; i < array_length(clickables); i++) {
		if clickables[i].depth <= tester.depth {
			tester.test(clickables[i], 
				clickables[i].bbox_left, clickables[i].bbox_top,
				clickables[i].bbox_right, clickables[i].bbox_bottom,
				clickables[i].depth);
		}
	}
	
	var instances = global.has_hoverables.instances();
	for (var i = 0; i < array_length(instances); i++) {
		instances[i].test_hoverables(tester);
	}
	
	if instance_exists(last_inst) last_inst.hovered = false;
	last_inst = tester.inst;
	if instance_exists(last_inst) last_inst.hovered = true;
	return tester.inst;
}

function get_hovered_object() {
	static last_frame = 0;
	static last_result = noone;
	
	if last_frame != current_frame {
		last_result = gather_hoverables();
		last_frame = current_frame;
	}
	return last_result;
}

function Hoverable() constructor {
	hovered = false;
}

function HoverableParent() : Hoverable() constructor {
	static test_children = function(tester, xbase, ybase, depthbase) {	};
}