/// @description Insert description here
// You can write your code in this editor
event_inherited();
can_collide = true;
image_index = irandom(image_number);

if instance_exists(Board) {
	visible = false
	alarm[0] = Board.editor ?  1 : manhatten_distance(x, y, Board.bbox_left, Board.bbox_top)/32}