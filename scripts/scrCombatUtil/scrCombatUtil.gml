

function resolve_target(target) {
	if is_int64(target) { //Enum check
		if target >= TARGETS.ALL && target <= TARGETS.ALL_ENEMIES {
			show_message("Multitarget used in a single target function! Fix that, it doesn't work!")
		}
		return resolve_target(get_item_target(target));
	}
	if is_struct(target) {
		if is_instanceof(target, Provider) {
			return resolve_target(target.get())
		}
		return struct_defget(target, "instance", struct_defget(target, "id", noone))
	}

	return target;
}

function resolve_multitarget(target) {
	if is_int64(target) {
		return resolve_target(get_item_target(target))
	}
	return resolve_target(target);
}

function provider_get(value) {
	return is_instanceof(value, Provider) ? value.get() : value;
}

function is_provider(value) {
	return is_instanceof(value, Provider)
}

function combat_active() {
	with CombatRunner return combat_started && !combat_ending;
	return false;
}

function battler_hurt(target, damage, source, reactable = true) {
	if damage <= 0 exit;
	target.hurt(damage)
	with instance_create_depth(target.x, target.y, target.depth - 1, obj_fx) {
		sprite_index = sprFXHitLarge
		needs_board = false
		
		scr_screenshake(5, 3, 0.2)
		sound_play_pitch(sndCoinBagHit, random_range(.8, 1.2))
	}
	with instance_create_layer(target.x, target.y, "FX", effectDamagePopup) {
		self.damage = -damage
	}
}

function battler_give_block(target, block) {
	target.block += block;	
	with instance_create_depth(target.x, target.y, target.depth - 1, obj_fx) {
		image_angle = 0
		sprite_index = sprFXShield
		needs_board = false
		
		sound_play_pitch(sndDouble, random_range(.8, 1.2))
	}	
}