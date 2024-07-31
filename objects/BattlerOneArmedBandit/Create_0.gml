/// @description 

// Inherit the parent event
event_inherited();

move_max = 3;
move_rerolls = 1;

odds = 25;

on_turn_end = function() {
	odds = 25;
}
var jackpot_damage = function() {
	if chance(odds, 100) return 20;
	return 0;
}

var increase_odds = function() {
	odds *= 2;
}

var setup_trash = function(move) {
	move.run(function() {
		var m = board_column_max();
		for (var i = 0; i < m; i++)
			place_trash_bricks(i, undefined, 1)
	})
	move.wait(10)
};

with add_action("BAR") {
	desc = "Suck them bones dry, kid"
	setup_trash(self)
	var damage = as_damage(3);
	hit(damage)
	set_intent(INTENT.ATTACK, damage);
}

with add_action("JACKPOT!") {
	var damage = as_damage(new FunctionProvider(jackpot_damage));
	hit(damage);
	set_intent(INTENT.ATTACK, "??")
	desc = "25% chance to deal 25 damage.\nDouble this chance for any upcoming JACKPOTS."
	
	run(increase_odds)
}

with add_action("RESPIN") {
	var b = 10;
	block(b);
	set_intent(INTENT.BLOCK, b)
	desc = string("Gain {0} block", b);
}