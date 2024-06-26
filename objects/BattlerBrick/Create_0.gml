/// @description 

// Inherit the parent event
event_inherited();

colorable = false;
mana_amount = 0;
is_destructible = false;
drop_chance = 0;
drop_amount = 0;
my_health = 50;

battler = noone;

on_ball = function(ball) {
	if instance_exists(battler) {
		battler_hurt(battler, ball.damage, ball, false)
	}
}