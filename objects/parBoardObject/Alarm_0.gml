/// @description Become Visible & Flash

visible = true

if is_visible {
	with instance_create_layer(x, y, "FX", obj_brick_flash) {
		sprite_index = other.sprite_index;
		image_xscale = other.image_xscale;
		image_yscale = other.image_yscale;
		image_angle = other.image_angle;
		image_index = other.image_index;
		image_speed = other.image_speed;
	}
}