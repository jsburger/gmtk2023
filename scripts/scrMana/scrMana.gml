enum MANA {
	RED,
	BLUE,
	YELLOW,
	
	MAX //Dont use this, its just meant to represent the last value in the enum so you know how many manas there are
}

#macro MANA_NONE -1

global.mana = array_create(MANA.MAX)
global.mana_gained = array_create(MANA.MAX)

//Reset mana when game restarted
on_encounter_start(mana_reset)

function mana_add(type, amount) {
	global.mana[type] += amount
	global.mana_gained[type] += amount
	with ManaDrawer blink[type] = 1
}

function mana_get_color(mana){
	switch mana {
		case MANA.RED:
			return #d12222
		case MANA.BLUE:
			return #4566d1
		case MANA.YELLOW:
			return #efc555
		default:
			return c_white	
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
	return c_white;
}

function mana_get_sum() {
	var sum = 0;
	for (var i = 0; i < MANA.MAX; ++i) {
		sum = sum + global.mana[i];
	}
	return sum;
}

function mana_reset() {
	for (var i = 0; i < MANA.MAX; ++i) {
		global.mana[i] = 0
	}
}

function mana_effect_create(x, y, color) {
	with instance_create_layer(x, y, "FX", effectManaGained) {
		image_blend = mana_get_color(color)
		self.color = color
		return self
	}
}