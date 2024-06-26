/// @description 

// Inherit the parent event
event_inherited();

if is_visible && instance_exists(battler) {
	with battler {
		visible = true
		with instance_create_layer(x, y, "FX", obj_brick_flash) {
			sprite_index = other.sprite_index;
		}
	}
}
