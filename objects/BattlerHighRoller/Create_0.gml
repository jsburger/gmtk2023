/// @description 

// Inherit the parent event
event_inherited();

set_hp(25)

size = ENEMY_SIZE.SMALL;
move_max = 1;

spr_icon = sprHighRollerIcon

roll_max = 6;
roll = irandom_range(1, roll_max);

var roll_damage = function() {
	return roll;
}

enemy_hurt = function() {
	if roll > 0 {
		roll = roll - 1;	
	}
}

on_turn_end = function() {
	roll_max = roll_max + 1;
	var roll_min = roll_max - 5;
	
	roll = irandom_range(roll_min, roll_max);
}

with add_action("Die") {
	var damage = as_damage(new FunctionProvider(roll_damage));
	hit(damage);
	set_intent(INTENT.ATTACK, damage)
	desc = "Deal 1-6 Damage.\nIncrease range by 1"
	
	wait(10)
}