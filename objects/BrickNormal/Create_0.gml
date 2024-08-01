/// @description 

// Inherit the parent event
event_inherited();


if !obj_board.editor && object_index == BrickNormal && chance(1, 60) {
	instance_create_layer(x, y, "Instances", BrickPipebomb);
	instance_destroy(self, false);
}

setup_freeze(sprBrickOverlayFrozen)
