function variable_instance_defget(instance, variable, def) {
    if variable_instance_exists(instance, variable) {
        return variable_instance_get(instance, variable)
    }
    return def
}

function struct_defget(struct, variable, def) {
	if struct_exists(struct, variable) {
		return struct_get(struct, variable);
	}
	return def;
}

function var_defget(inst, variable, def) {
	return struct_defget(inst, variable, def)
}