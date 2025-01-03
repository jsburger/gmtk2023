event_inherited();
sound_play_pitch(sndExplosion, 1);
var list = ds_list_create();

scr_screenshake(10, 2, 0.2);

for (var _y = Board.bbox_top; _y <= Board.bbox_bottom; _y += TILE_WIDTH) {
	with(instance_create_layer(x, _y, "Projectiles", obj_explosion)) {
		image_angle = random(360);
		collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_block, 0, 1, list, false)
		if stay_inside_board(){instance_destroy()}
	}
}


for (var i = 0; i < ds_list_size(list); i++) {
	with list[| i] {
		if is_destructible && nexthurt <= current_time{
			if is_destructible my_health--;
			nexthurt = current_time + 5;
			if my_health <= 0{
				instance_destroy();
			}
		}
	}
}

ds_list_destroy(list)