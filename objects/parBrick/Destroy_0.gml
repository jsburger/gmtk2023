/// @description 

if mana_amount > 0 && is_mana(color) {
	mana_add(color, mana_amount)
	mana_effect_create(x, y, color, mana_amount)
}

if drop_gibs with instance_create_layer(x, y, "Instances", Gibs) {
	image_blend = mana_get_color(other.color)
	motion_set(random_range(60, 120), irandom_range(3, 5));
}