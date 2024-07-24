/// @description 

// Inherit the parent event
event_inherited();

spr_damaged = sprBombLit;
on_hurt = function(damage) {
	sprite_index = spr_damaged
	sound_play(sndBombLit);
}

can_take_damage = true;
hp = 2;

ball_bounce = method(self, bounce_rectangular);

on_ball_impact = method(self, impact_normal);