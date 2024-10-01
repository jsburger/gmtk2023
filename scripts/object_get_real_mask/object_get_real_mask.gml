function object_get_real_mask(object) {
	var mask = object_get_mask(object);
	if mask == -1 return object_get_sprite(object);
	return mask;
}