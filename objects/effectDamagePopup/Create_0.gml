/// @description 

// Inherit the parent event
event_inherited();

needs_board = false;
curve = animcurve_get_channel(curveDamagePopup, "curve1");
progress_max = 1.5 sec;
damage = 1;
tilt = random_range(-12, 12)
var range = 15;
x += random_range(-range, range);
y += random_range(-range, range);
var d = depth;
with effectDamagePopup d = min(d, depth);
depth = d - 1;