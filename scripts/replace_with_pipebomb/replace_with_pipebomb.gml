function replace_with_pipebomb(vertical = false) {
	if !obj_board.editor && is_this && chance(1, 60) {
		with instance_create_layer(x, y, layer, vertical ? BrickPipebombV : BrickPipebomb) {
			alarm[0] = other.alarm[0];
		}
		instance_destroy(self, false);
		return true;
	}
	return false;
}