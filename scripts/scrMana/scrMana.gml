enum MANA {
	RED,
	BLUE,
	YELLOW,
	
	MAX //Dont use this, its just meant to represent the last value in the enum.
}

#macro MANA_NONE -1

//Todo: make one color enum, add MANA_MIN and MANA_MAX macros which are just red and yellow for loops
// And make gray 0

enum COLORS {
	NONE = -1,
	RED, BLUE, YELLOW,
	PURPLE, GREEN, ORANGE,
	MAX
}

#macro MANA_MIN COLORS.RED
#macro MANA_MAX COLORS.YELLOW
#macro MANA_LOOP var i = MANA_MIN; i <= MANA_MAX; i++


global.mana = array_create(MANA.MAX)
global.mana_gained = array_create(MANA.MAX)
global.mana_effects = {attack: 0, block: 0}

//Reset mana when game restarted
on_encounter_start(mana_reset)
on_board_clear(mana_effects_clear)

function mana_add(type, amount) {
	ITEM_LOOP {
		item.on_mana_gained(type, amount);
	}
	with EnemyBattler if variable_instance_exists(self, "on_mana_gained") {
		on_mana_gained(type, amount)
	}
	if is_extra_color(type) {		
		var decompose = color_decompose(type);
		for (var i = 0; i <= 1; i++) {
			mana_add(decompose[i], amount)
		}
	}
	else {
		global.mana[type] += amount
		global.mana_gained[type] += amount
		with ManaDrawer blink[type] = 1
	}
}

function mana_spend(color, amount) {
	global.mana[color] -= amount;
	with ManaDrawer blink[color] = 1
}

function mana_subtract_all(amount) {
	for (var i = 0; i < MANA.MAX; ++i) {
		if global.mana[i] >= amount {
			global.mana[i] -= amount
			with ManaDrawer blink[i] = 1
		}
		else {
			global.mana[i] = 0;	
		}
	}
}

/// If a color is mana, IE Red, Blue, Yellow
function is_mana(color) {
	return in_range_exc(color, MANA_NONE, MANA.MAX);
}
/// If a color can be CONVERTED to mana; IE Red, Orange, Blue, Purple
function is_valid_mana(color) {
	return in_range_exc(color, MANA_NONE, COLORS.MAX);
}
function is_valid_color(color) {
	return color >= MANA_NONE && color < COLORS.MAX;
}
function is_extra_color(color) {
	return color >= COLORS.PURPLE && color < COLORS.MAX;
}

function color_decompose(color) {
	switch color {
		case COLORS.PURPLE: return [COLORS.RED, COLORS.BLUE];
		case COLORS.GREEN: return [COLORS.YELLOW, COLORS.BLUE];
		case COLORS.ORANGE: return [COLORS.RED, COLORS.YELLOW];
		default: return color;
	}
}

function mana_get_color(mana){
	switch mana {
		case MANA.RED:
			return #aa392c
		case MANA.BLUE:
			return #447ea5
		case MANA.YELLOW:
			return #cdb163
		case COLORS.PURPLE:
			return #7633a6
		case COLORS.GREEN:
			return #22b14c
		case COLORS.ORANGE:
			return #db6b32
		default:
			return #919a9f	
	}
}

function mana_get_color_alt(mana, index) {
	static colors = [
		[ #d12222, #de3e59, #d13f22, #ed64a8],
		[ #4566d1, #45b5d1, #3932c7, #5430c9],
		[ #efc555, #9be354, #e7ef55, #ab8646]
	];
	if mana < MANA.MAX && mana >= MANA.RED {
		return colors[mana][index];
	}
	return #919a9f;
}

function mana_get_sum() {
	var sum = 0;
	for (var i = 0; i < MANA.MAX; ++i) {
		sum = sum + global.mana[i];
	}
	return sum;
}

function mana_get_highest() {
	var highest = 0;
	for (var i = 0; i < MANA.MAX; ++i) {
		if (global.mana[i] > highest){
			highest = global.mana[i];	
		}
	}
	return highest;
}

function color_get_name(color) {
	switch color {
		case COLORS.NONE  : return "gray";
		case COLORS.RED   : return "red";
		case COLORS.BLUE  : return "blue";
		case COLORS.YELLOW: return "yellow";
		case COLORS.PURPLE: return "purple";
		case COLORS.GREEN : return "green";
		case COLORS.ORANGE: return "orange";
	}
}

function mana_reset() {
	for (var i = 0; i < MANA.MAX; ++i) {
		global.mana[i] = 0
	}
}

function mana_effect_create(x, y, color, count) {
	repeat(count) {
		with instance_create_layer(x, y, "FX", effectManaGained) {
			image_blend = mana_get_color(color)
			self.color = color
			return self
		}
	}
}

function mana_give_at(x, y, color, count) {
	//if is_extra_color(color) {
	//	var decompose = color_decompose(color);
	//	for (var i = 0; i <= 1; i++) {
	//		mana_give_at(x, y, decompose[i], count)
	//	}
	//}
	//else {
		mana_add(color, count);
		mana_effect_create(x, y, color, count);
	//}
}

function mana_give_board(x, y, color, count) {
	mana_give_at(x, y, color, count);
	mana_stat_effect_give(x, y, color, count);
	Board.splat_start();
	draw_sprite_ext(sprManaSplat, 0, x, y,
		choose(-1, 1), choose(-1, 1), random(360), mana_get_color(color), 1);
	Board.splat_end();
}

function mana_stat_effect_give(x, y, color, count) {
	if is_extra_color(color) {
		var decompose = color_decompose(color);
		for (var i = 0; i <= 1; i++) {
			mana_stat_effect_give(x, y, decompose[i], count)
		}
	}
	else {
		switch color {
			case COLORS.RED:
				global.mana_effects.attack += count;
				with effect_create(x, y, effectStatGained) {
					sprite_index = sprManaEffectAttack;
					value = count;
				}
				break;
			case COLORS.BLUE:
				global.mana_effects.block += count;
				with effect_create(x, y, effectStatGained) {
					sprite_index = sprManaEffectDefend;
					value = count;
				}
				break;
		}
	}
}

function mana_effects_clear() {
	with global.mana_effects {
		attack = 0;
		block = 0;
	}
}