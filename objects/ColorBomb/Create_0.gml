/// @description 

// Inherit the parent event
event_inherited();

colorable = true;

can_take_damage = true;
hp = 1;

ball_bounce = method(self, bounce_rectangular);

on_ball_impact = method(self, impact_normal);