/// @description 

// Inherit the parent event
event_inherited();

//FX
if !irandom(40 - (speed > 0) * 25){
	with instance_create_layer(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), "FX", obj_sparkle){
		depth = other.depth + choose(-1, 1);
	}
}

if has_landed {
	fade += 1;
	var frequency = 7;
	image_alpha = (fade mod frequency >= (frequency / 2));
	if fade >= fade_max {
		instance_destroy();
	}
}