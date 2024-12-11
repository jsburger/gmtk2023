/// @description Explode

// Inherit the parent event
event_inherited();

scr_screenshake(10, 2, 0.2);
sound_play(sndExplosion);

var list = ds_list_create(),
	rect = get_rectangle(),
	collisions = collision_rectangle_list(
		rect.x1, rect.y1, rect.x2, rect.y2,
		parBoardObject, true, true, list, false);

var _min = is_vertical ? obj_board.bbox_top : obj_board.bbox_left,
	_max = is_vertical ? obj_board.bbox_bottom : obj_board.bbox_right;
for (var i = _min; i <= _max; i += TILE_WIDTH) {
	with(instance_create_layer(is_vertical ? x : i, is_vertical ? i : y, "Projectiles", obj_explosion)) {
		image_angle = random(360);
		if stay_inside_board() {
			instance_destroy()
		}
	}
}

for (var i = 0; i < ds_list_size(list); i++) {
	var inst = list[| i];
	if !instance_exists(inst) continue;
	if inst.can_collide brick_hit(inst, 1, self)
}

ds_list_destroy(list);