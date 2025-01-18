/// @description 

if mana_amount > 0 && is_valid_mana(color) {
	mana_give_board(x, y, color, mana_amount)
}

if drop_gibs with instance_create_layer(x, y, "Instances", Gibs) {
	image_blend = mana_get_color(other.color)
	motion_set(random_range(60, 120), irandom_range(3, 5));
}

if is_cursed {
	proc_curse()
}