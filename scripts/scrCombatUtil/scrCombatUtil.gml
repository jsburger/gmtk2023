function resolve_target(target) {
	if is_int64(target) { //Enum check
		return get_item_target(target)
	}
	if is_struct(target) {
		if is_instanceof(target, Provider) {
			return resolve_target(target.get())
		}
		return struct_defget(target, "instance", struct_defget(target, "id", noone))
	}

	return noone
}

function provider_get(value) {
	return is_instanceof(value, Provider) ? value.get() : value;
}

function battler_hurt(target, damage, source, reactable = false) {
	target.hurt(damage)
	with instance_create_depth(target.x, target.y, target.depth - 1, obj_fx) {
		sprite_index = spr_hit_large
		needs_board = false
	}
}

function battler_give_block(target, block) {
	target.block += block;	
	with instance_create_depth(target.x, target.y, target.depth - 1, obj_fx) {
		sprite_index = spr_portal_fx_blue
		needs_board = false
	}	
}