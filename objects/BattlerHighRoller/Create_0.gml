/// @description 

// Inherit the parent event
event_inherited();

set_hp(25)

size = ENEMY_SIZE.SMALL;
move_max = 1;

spr_icon = sprHighRollerIcon

roll = 6;

var roll_damage = function() {
	return roll;
}

enemy_hurt = function() {
	if roll > 0 {
		roll = roll - 1;	
	}
}

on_turn_end = function() {
	roll = 6;
}

with add_action("JACKPOT!") {
	var damage = as_damage(new FunctionProvider(roll_damage));
	hit(damage);
	set_intent(INTENT.ATTACK, damage)
	desc = "Deal 6 Damage."
	
	//buff_strength(1)
	
	wait(10)
}