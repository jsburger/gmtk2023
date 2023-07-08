function variable_instance_defget(instance, variable, def) {
    if variable_instance_exists(instance, variable) {
        return variable_instance_get(instance, variable)
    }
    return def
}