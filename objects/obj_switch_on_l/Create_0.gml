/// @description Insert description here
event_inherited();
direction = 0;
spr_on = sprSwitchLeftOff;
spr_off = sprSwitchLeftOn;

with instance_create_depth(bbox_left + TILE_MIN / 2, bbox_bottom - TILE_MIN / 2, depth - 1, obj_iohelper){
	creator = other;
	input = false;
	other.output = id;
}
with instance_create_depth(bbox_left + TILE_MIN / 2, bbox_top + TILE_MIN / 2, depth - 1, obj_iohelper){
	creator = other;
	input = true;
	other.input = id;
}