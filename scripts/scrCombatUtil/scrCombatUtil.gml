function resolve_target(target) {
	if instance_exists(target) return target
	if is_struct(target) {
		if is_instanceof(target, Provider) {
			return resolve_target(target.get())
		}
		return struct_defget(target, "instance", noone)
	}
	if is_real(target) {
		return get_item_target(target)
	}
	return noone	
}

function provider_get(value) {
	return is_instanceof(value, Provider) ? value.get() : value;
}

function battler_hurt(target, damage, source, reactable = false) {
	target.hurt(damage)
}