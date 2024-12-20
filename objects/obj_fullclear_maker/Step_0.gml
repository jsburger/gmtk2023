/// @description Insert description here
// You can write your code in this editor

repeat(irandom_range(1,4) + real(teeth)) {
	
	if teeth {
		var obj = obj_tooth;
	}
	else {
		var obj = choose(obj_coin, obj_coin_silver, obj_coin, obj_coin_silver, obj_coin_gold);
	}

	if payout > 0 {
		with instance_create_layer(random_range(Board.x - 40, Board.x + 40), Board.y - random_range(0, 10), "Instances", obj) {
			other.payout -= value
			motion_add(90, random_range(2, 5));
			if !place_meeting(x, y, obj_explosion_radius) {
				motion_add(point_direction(Board.x, Board.y, x, y), random(4) + 2)
				vspeed -= random_range(0, 5)
			}
		}
	}
}
if payout <= 0 instance_destroy()