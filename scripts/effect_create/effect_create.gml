function effect_create(x, y, object = obj_fx) {
	return instance_create_layer(x, y, "FX", object);
}