/// @description Insert description here
event_inherited();
if random(60) < 1 && !Board.editor && object_index == obj_block_v{
	instance_create_layer(x,y,"Instances",obj_super_block_v);
	drop_chance = 0;
	instance_destroy();
}

spr_frozen = sprBrickVerticalFrozen;