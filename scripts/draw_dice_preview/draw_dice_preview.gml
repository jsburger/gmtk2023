// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function draw_dice_preview(_x, _y, gunangle) {
	draw_set_alpha(.8)
	with parBoardObject ghost_hits = 0;
	with instance_create_layer(_x, _y, "Instances", PlayerBall) {
		is_ghost = true;
		
		var is_ball = instance_is(other, PlayerBall);
		if is_ball {
			motion_set(other.direction, other.speed)
			vars_apply(other)
			is_ghost = true;
			var vars = variable_instance_get_names(self);
			for (var i = 0; i < array_length(vars); i++) {
				if is_method(variable_instance_get(self, vars[i])) {
					//trace(vars[i])
					variable_instance_set(self, vars[i], method(self, variable_instance_get(self, vars[i])))
				}
			}
		}
		else motion_set(gunangle, 18)
		
		var points = [{"x": x, "y":y}];
		
		var tries = 0 + is_ball,
			xLast = x,
			yLast = y,
			maxTries = is_ball ? 30 : 3000;
			
		var segments = 2;
		
		while (tries <= maxTries) {
			tries += 1
			if tries != 1 {
				event_perform(ev_step, ev_step_normal)
			}
			
			//Step Movement
			if(friction != 0 && speed != 0){
			    speed -= min(abs(speed), friction) * sign(speed);
			}
			if(gravity != 0){
			    hspeed += lengthdir_x(gravity, gravity_direction);
			    vspeed += lengthdir_y(gravity, gravity_direction);
			}
			xprevious = x;
			yprevious = y;
			if(speed != 0){
			    x += hspeed;
			    y += vspeed;
			}
			// Shouldn't really matter.
			if alarm[0] > 0 && false {
				alarm[0] -= 1;
				if alarm[0] == 0 {
					event_perform(ev_alarm, 0)
				}
			}
			
			//if (tries mod 2 == 1) {
			//	draw_line_width_color(x, y, xLast, yLast, 3, c_white, c_white)
			//}
			
			//xLast = x
			//yLast = y
			
			var dist = point_distance(xLast, yLast, x, y);
			while dist >= 10 {
				var dir = point_direction(xLast, yLast, x, y);
				xLast += lengthdir_x(min(dist, 10), dir)
				yLast += lengthdir_y(min(dist, 10), dir)
				array_push(points, {"x": xLast, "y": yLast})
				dist = point_distance(xLast, yLast, x, y);
				//xLast = x
				//yLast = y
			}
			
			
			//Collisions
			if place_meeting(x, y, parBoardObject) {
				var list = ds_list_create(),
				    bricks = instance_place_list(x, y, parBoardObject, list, false);
				for (var i = 0; i < bricks; i++) {
					var brick = list[| i];
					if instance_exists(brick) {
						
						var lastx = x,
							lasty = y,
							lastPierce = pierce;
							
						with brick with other 
							event_perform(ev_collision, parBoardObject)
							
						if has_bounced {
							if array_length(points) mod 2 == 1 {
								if instance_is(brick, Portal) array_push(points, {x: lastx, y: lasty})
								else array_push(points, {x, y})
							}
							array_push(points, {x, y})
							xLast = x;
							yLast = y;
							if brick.stops_preview {
								//tries = max(maxTries - 30, tries)
								segments -= 1;
							}
						}
					}
				}
				ds_list_destroy(list)
				
				// This might be more accurate. Not sure.
				//with parBoardObject if place_meeting(x, y, other) {
				//	with other event_perform(ev_collision, parBoardObject)
				//}
			}
			if segments <= 0 break
			
			//End Step
			if stay_inside_board() {
				break;
			}
			
		}
		
		array_push(points, {"x": x, "y":y})
		
		for (var i = 1; i < array_length(points); i += 2) {
			draw_line_width_color(points[i].x, points[i].y, points[i - 1].x, points[i - 1].y, 3, c_white, c_white)
		}
		
		draw_sprite(sprPreviewEnd, 0, x, y)
		draw_set_alpha(1)
		
		instance_destroy()
	}
}