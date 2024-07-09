/// @description Insert description here
event_inherited();
spr_on = sprBrickToggleOn;
spr_off = sprBrickToggleOff;
can_collide = false;
my_health = 99999;
is_destructible = false;
input = true;
image_index = irandom(image_number);
image_speed = 0;
depth += 20;

with instance_create_depth(bbox_right - TILE_MIN / 2, bbox_bottom - TILE_MIN / 2, depth - 1, obj_iohelper){
	creator = other;
	input = true;
	other.io = id;
}