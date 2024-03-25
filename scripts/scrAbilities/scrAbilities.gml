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

function Ability(needsTarget = true) constructor {
	
	needs_target = needsTarget
	costs = array_create(MANA.MAX);
	
	name = "Ability"
	desc = "Description"
	sprite_index = spr_chip
	
	static act = function() {
		
	}
	
	static set_cost = function(type, amount) {
		costs[type] = amount
	}
	
	static can_cast = function() {
		for (var i = 0; i < MANA.MAX; ++i) {
		    if global.mana[i] < costs[i] return false
		}
		return true
	}
	
	static spend_mana = function() {
		for (var i = 0; i < MANA.MAX; ++i) {
		    global.mana[i] -= costs[i]
		}
	}
}

function BasicAttack(Damage) : Ability(true) constructor {
	damage = Damage
	
	static act = function() {
		attack(TARGETS.AIMED, damage, 1, true)
	}
}

function RedManaAttack(Damage, Cost) : BasicAttack(true) constructor {
	damage = Damage
	set_cost(MANA.RED, Cost)
	
}

function FunctionAbility(func, needsTarget = true) : Ability(needsTarget) constructor {
	callback = func
	
	static act = function() {
		callback()
	}
}