// Called in GlobalStep
/// @ignore
function Clickables_Step() {
    
    if button_pressed(inputs.shoot) {
		//Get hovered object
		var clicked = get_hovered_clickable();
		if clicked != noone {
			if !instance_is(clicked, obj_board) with obj_board active = false;
			//If combat is targeting right now, check for targets before clicks
			if (instance_exists(CombatRunner) && CombatRunner.targeting) {
				if variable_instance_exists(clicked, "get_target_info") {
					CombatRunner.accept_target(clicked.get_target_info())
				}
				else {
					CombatRunner.cancel_targeting()
				}
			}
			else {
				with clicked on_click(mouse_x - bbox_left, mouse_y - bbox_top)
			}
		}
		else {
			//Disable board when anything is clicked.
			with obj_board active = false;
		}
    }
    
}


function get_hovered_clickable() {
	static last_frame = 0;
	static last_result = noone;
	
	if last_frame != current_frame {
		last_frame = current_frame;
		last_result = noone;
		
		//Fetch clickables
		var clickables = global.clickable_objects.instances();
        if array_length(clickables) > 0 {
            var found = [];
            for (var i = 0, l = array_length(clickables); i < l; i++) {
                var inst = clickables[i];
                var range = variable_instance_defget(inst, "click_range", 0);
                if distance_to_bbox(mouse_x, mouse_y, inst) <= range {
                    if (!variable_instance_exists(inst, "can_click") || inst.can_click()) {
                        array_push(found, inst)
                    }
                }
            }
    
            var len = array_length(found);
            if len > 0 {
                if len > 1 {
                    //Sort by depth, putting the highest instances on top
                    array_sort(found, function(current, next) {
                        if current.depth > next.depth {
                            return 1
                        }
                        if current.depth == next.depth {
                            return 0
                        }
                        return -1
                    })
                }
                var clicked = found[0];
				last_result = clicked
            }
        }
	}
	return last_result
	
	
}