// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function draw_dice_preview(_x, _y, gunangle) {
	draw_set_alpha(.8)
	with instance_create_layer(_x, _y, layer, Ball) {
		is_ghost = true;
		
		motion_set(gunangle, 18)
		
		var points = [{"x": x, "y":y}];
		
		var tries = 0,
			xLast = x,
			yLast = y;
		while (tries <= 200) {
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
			//TODO: seed throw rng so this is consistent
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
					if instance_exists(brick) && place_meeting(x, y, brick) {
						with brick with other 
							event_perform(ev_collision, parBoardObject)
					}
				}
				ds_list_destroy(list)
				
				// This might be more accurate. Not sure.
				//with parBoardObject if place_meeting(x, y, other) {
				//	with other event_perform(ev_collision, parBoardObject)
				//}
			}
			//var list = ds_list_create()
			//var bricks = instance_place_list(x, y, par_bricklike, list, false);
			//var shouldBreak = false;
			//for (var i = 0; i < bricks; i++) {
			//	var brick = list[| i];
			//	if instance_exists(brick) && brick.can_collide {
			//		if instance_is(brick, obj_portal) {
			//			var tpX = x, tpY = y;
			//			if brick.teleport(self) {
			//				if array_length(points) mod 2 == 1 {
			//					array_push(points, {"x": tpX, "y": tpY})
			//				}
			//				array_push(points, {"x": x, "y": y})
			//				xLast = x
			//				yLast = y
			//			}
			//		}
			//		else if instance_is(brick, obj_launcher) {
			//			if brick != launcher {
			//				nograv = true
			//				launcher = brick
			//				if array_length(points) mod 2 == 1 {
			//					array_push(points, {"x": x, "y": y})
			//				}
			//				array_push(points, {"x": brick.x, "y": brick.y})
			//				motion_set(brick.direction, maxspeed)
			//				x = brick.x
			//				y = brick.y
			//				xLast = x
			//				yLast = y
			//			}
			//		}
			//		else {
			//			shouldBreak = true
			//			break;
			//		}
			//	}
			//}
			//ds_list_destroy(list)
			//if shouldBreak break;
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