// Called in GlobalStep
function Clickables_Step() {
    
    if button_pressed(inputs.shoot) {
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
                with clicked on_click(mouse_x - bbox_left, mouse_y - bbox_top)
            }
        }
    }
    
}