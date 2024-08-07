/// @description 
board_object_exit;

event_inherited();

if chance(1, 13) {
	var dist = random_range(32, 64), ang = random(360);
	with instance_create_layer(x + lengthdir_x(dist, ang), y + lengthdir_y(dist, ang), "FX", obj_portal_fx) {
		image_speed *= random_range(.3, .8);
		target = other;
		sprite_index = other.spr_fx;
		motion_set( point_direction(x, y, other.x, other.y) + 90, .5 + random(1));
	}
}