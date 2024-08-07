/// @description 
board_object_exit;

if is_burning {
	if chance(1, 40) { 
		with instance_create_depth(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), 
			choose(1, -1, -1), obj_fx, {sprite_index: sprFXFireSmall}) {
				image_angle = 0;
				motion_set(90, random(.3))
			}
	}
}