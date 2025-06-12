/// @description 

// Inherit the parent event
event_inherited();

spr_damaged = sprBombLit;
on_hurt = function(damage) {
	if hp > 0 {
		sprite_index = spr_damaged
		sound_play(sndBombLit);
	}
}

set_hp(2);

ball_bounce = method(self, bounce_circular);

on_ball_impact = method(self, impact_normal);
