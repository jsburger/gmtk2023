/// @description Insert description here
if irandom(99) < drop_chance{
	repeat(drop_amount){
		 with instance_create_layer(x, y, "Instances", obj_coin_gold){
			motion_set(random_range(60, 120), irandom_range(3, 5));
		}
	}
}