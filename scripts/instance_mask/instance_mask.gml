function instance_mask(inst) {
	return inst.mask_index == -1 ? inst.sprite_index : inst.mask_index;
}