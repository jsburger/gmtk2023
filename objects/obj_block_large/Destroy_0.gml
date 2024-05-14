// Inherit the parent event
event_inherited();

repeat(2){
	with instance_create_layer(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), "Instances", Gibs){
		image_blend = mana_get_color(other.color)
		motion_set(random_range(60, 120), irandom_range(3, 5));
		if !place_meeting(x, y, par_bricklike) instance_destroy(self, false);
	}
}
