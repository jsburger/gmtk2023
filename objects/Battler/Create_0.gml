function set_hp(h) {
	hpmax = h
	hp = h
}

set_hp(50)

block = 0

statuses = new StatusHolder(self);

canact = true

hurt = function(damage) {
	block -= damage
	if block < 0 {
		hp += block
		block = 0
	}
	on_hurt(damage)
	if hp <= 0 {
		hp = 0
		die()
	}
}

/// Use this for hooks rather than hurt
on_hurt = function(damage) {
	
}

turn_start = function() {
	statuses.on_turn_start()
}

turn = function() {
	
}

turn_end = function() {
	statuses.on_turn_end()
}
__turn_end = turn_end;

battle_start = function() {
	
}

die = function() {
	image_alpha = .5
	canact = false
}