/// @description Insert description here
event_inherited();
direction = 90;
spr_on = sprSwitchUpOff;
spr_off = sprSwitchUpOn;

with instance_create_depth(bbox_left + TILE_MIN / 2, bbox_top + TILE_MIN / 2, depth - 1, obj_iohelper){
	creator = other;
	input = false;
	other.output = id;
}
with instance_create_depth(bbox_right - TILE_MIN / 2, bbox_top + TILE_MIN / 2, depth - 1, obj_iohelper){
	creator = other;
	input = true;
	other.input = id;
}