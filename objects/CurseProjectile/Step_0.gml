/// @description 

motion_add(point_direction_struct(self, target_position), .3)

if odd {
	with instance_create_layer(x, y, "FX", obj_fx) {
		sprite_index = other.sprite_index;
		image_speed = 2;
		image_blend = c_fuchsia;
		image_alpha = .4;
		image_xscale = .8;
		image_yscale = .8;
		image_angle = other.image_angle;
		depth = other.depth + 1;
	}
	odd = false;
}
else odd = true;