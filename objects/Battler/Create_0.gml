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
display_health = new MeterInterpolator(self, function() {
	return hp;
});
hpsize = 2;

function set_hp_max(h) {
	hpmax = h;
	hpsize = string_length(string(h));
}

function set_hp(h) {
	set_hp_max(h);
	hp = h
	display_health.set(h);
}

set_hp(50)

block = 0
block_display = new BlockInterpolator(self, function() {
	return block;
})

statuses = new StatusHolder(self);

canact = true

/// @ignore
/// @param {Struct.DamageInfo} damage
enemy_hurt = function(damage) {}
hurt = function(damage) {
	block -= damage;
	var unblocked = 0;
	if block < 0 {
		hp += block
		unblocked = -block;
		block = 0
	}
	var info = new DamageInfo(damage, unblocked);
	on_hurt(info)
	if instance_is(self, EnemyBattler) {
		enemy_hurt(info)
	}
	if hp <= 0 {
		hp = 0
		die()
	}
}

/// Use this for hooks rather than hurt
/// @param {Struct.DamageInfo} info
on_hurt = function(info) {
	
}

turn_start = function() {
	block = 0;
	statuses.on_turn_start()
}

turn = function() {
	
}

/// @func turn_end
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

