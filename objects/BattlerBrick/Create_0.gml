/// @description 

// Inherit the parent event
event_inherited();

set_hp(50)
fullclear_ignore = true;

battler = noone;
size = ENEMY_SIZE.NORMAL;
spr_bg = sprEnemyBg;

on_hurt = function(damage, source) {
	if instance_exists(battler) {
		battler_hurt(battler, damage, source, false)
	}
	hp += damage
}

bounciness = 0.8;

ball_bounce = method(self, bounce_rectangular);
on_ball_impact = method(self, impact_normal);