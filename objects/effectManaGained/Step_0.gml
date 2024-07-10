/// @description 

if instance_exists(target) {
	var dir = point_direction(x, y, target.x, target.y);
	
	motion_add(dir, 1);
	
	if speed > speedmax speed = speedmax;
	
	var scale = max((distance_to_object(target)/distance_ref) / 2, .25);
	image_xscale = scale;
	image_yscale = scale;
	
	if point_distance(x, y, target.x, target.y) < 10 {
		//with ManaDrawer blink[other.color] = 1
		instance_destroy();
	}
}