/// @description 

// Inherit the parent event
event_inherited();

set_hp(20)

size = ENEMY_SIZE.SMALL;
move_max = 1;

spr_icon = sprHighRollerIcon

roll_max = 6;
roll = irandom_range(1, roll_max);

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


add_action("Die", function() {
	var roll_damage = function() {
		return roll;
	}
	var roll_range = function() {
		return string("{0}-{1}", roll_max - 5, roll_max)
	}

	MOVESTART
	var damage = as_damage(new FunctionProvider(roll_damage));
	hit(damage);
	add_intent(new Intent(sprIntentAttack, damage))
		.with_desc(format("Deal {0} Damage.\nIncrease range by 1", roll_range));
	
	wait(10)
	MOVEEND
})