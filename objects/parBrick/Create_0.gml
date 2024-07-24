/// @description 

// Inherit the parent event
event_inherited();

can_take_damage = true;

ball_bounce = method(self, bounce_rectangular)

snd_impact = sndDieHitBrick;

on_ball_impact = method(self, impact_normal);

#region Mana Drops
	mana_amount = 0;
#endregion

drop_gibs = true;