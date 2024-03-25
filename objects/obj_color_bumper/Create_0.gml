/// @description Insert description here
// You can write your code in this editor
event_inherited();
is_destructible = false;

active = true;
bounces = 5;

if instance_exists(obj_board) {
	visible = false
	alarm[0] = obj_board.editor ?  1 : manhatten_distance(x, y, obj_board.bbox_left, obj_board.bbox_top)/32}