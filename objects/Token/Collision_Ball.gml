/// @description Become active
if !other.is_coin && !other.is_ghost {
	with instance_create_layer(x, y, layer, spawn_object) {
		motion_set(random_range(60, 120), irandom_range(1, 3));
		if colorable {
			set_color(other.color);
		}
	}
	instance_destroy(self)
}
