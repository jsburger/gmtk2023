// Takes priority over on_click when CombatRunner is targeting.
get_target_info = function() {
	return {
		type: TARGET_TYPE.BATTLER,
		instance: other
	}
}
//Here because being targetable means being clickable. Will fix later. Maybe.
on_click = function() {}

hpmax = 50;
hp = 50;
display_health = new MeterInterpolator(function() {
	return hp;
});
hpsize = 2;

function set_hp(h) {
	hpmax = h
	hp = h
	display_health.set(h);
	hpsize = string_length(h);
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
	block = 0;
	statuses.on_turn_start()
}

turn = function() {
	
}

/// @ignore
turn_end = function() {
	statuses.on_turn_end()
	on_turn_end()
}
/// Override to add behavior on turn end (after statuses)
on_turn_end = function() {}

battle_start = function() {
	
}

die = function() {
	image_alpha = .5
	canact = false
	battler_died(self)
	on_die()
}

/// Use this instead of die to override
on_die = function() {}

