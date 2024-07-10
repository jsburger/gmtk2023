/// @description Drop mone

if drop_chance > 0 {
	if color > -1 {
		mana_add(color, mana_amount)
		mana_effect_create(x, y, color)
	}
}

if irandom(99) < drop_chance{
	repeat(drop_amount){
		 with instance_create_layer(x, y, "Instances", obj_coin){
			motion_set(random_range(60, 120), irandom_range(3, 5));
		}
	}
}

with instance_create_layer(x, y, "Instances", Gibs){
	image_blend = mana_get_color(other.color)
	motion_set(random_range(60, 120), irandom_range(3, 5));
}