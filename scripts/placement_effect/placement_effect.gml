function placement_effect(inst) {
	var _factor = (inst.sprite_width * inst.sprite_height) / (TILE_MIN * 8);
	repeat(3 + _factor) with instance_create_depth(inst.x, inst.y, inst.depth + 21 * choose(1, 1, 1, -1), obj_dust){
		motion_add(random(360), random_range(3, 6) * (1 + _factor / 40));
		friction = random_range(.35, .2) * (1 + _factor / 40);
		image_speed *= random_range(.8, 1);
		gravity = -.1;
	}
}