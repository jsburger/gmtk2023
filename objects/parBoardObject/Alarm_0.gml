/// @description Become Visible & Flash

visible = true

if is_visible {
	with instance_create_layer(x, y, "FX", obj_brick_flash) {
		sprite_index = other.sprite_index;
		image_xscale = other.image_xscale;
		image_yscale = other.image_yscale;
	}
}