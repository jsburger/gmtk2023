/// @description Bounce off chip
// You can write your code in this editor
repeat(6){
	with instance_create_depth(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), other.depth + choose(-1, 1), obj_sparkle){
		image_speed *= random_range(.7, 1.3);
		motion_add(random(360), random_range(1, 3));
		friction = .1;
	}
}
//global.money += value
instance_destroy(self)