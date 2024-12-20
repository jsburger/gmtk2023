/// @description Insert description here
// You can write your code in this editor
event_inherited();
is_destructible = false;

active = true;
bounces = 5;

if instance_exists(Board) {
	visible = false
	alarm[0] = Board.editor ?  1 : manhatten_distance(x, y, Board.bbox_left, Board.bbox_top)/32}