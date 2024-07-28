/// @description 

// Inherit the parent event
event_inherited();

hp = 50;
can_take_damage = true;

battler = noone;

on_hurt = function(damage, source) {
	if instance_exists(battler) {
		battler_hurt(battler, damage, source, false)
	}
	hp += damage
}

ball_bounce = method(self, bounce_rectangular);
on_ball_impact = method(self, impact_normal);