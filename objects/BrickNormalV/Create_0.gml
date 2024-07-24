/// @description 

// Inherit the parent event
event_inherited();

if !obj_board.editor && object_index == BrickNormalV && chance(1, 60) {
	instance_create_layer(x, y, "Instances", BrickPipebombV);
	instance_destroy(self, false);
}

setup_freeze(sprBrickVerticalOverlayFrozen)

