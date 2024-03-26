enum MANA {
	RED,
	BLUE,
	YELLOW,
	
	MAX //Dont use this, its just meant to represent the last value in the enum so you know how many manas there are
}

global.mana = array_create(MANA.MAX)
global.mana_gained = array_create(MANA.MAX)

//Reset mana when game restarted
add_reset_callback(mana_reset)

function mana_add(type, amount) {
	global.mana[type] += amount
	global.mana_gained[type] += amount
}

function mana_reset() {
	for (var i = 0; i < MANA.MAX; ++i) {
		global.mana[i] = 0
	}
}