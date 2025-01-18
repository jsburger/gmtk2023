/// @description 

// Inherit the parent event
event_inherited();

needs_board = false;
image_angle = random_range(-5, 5);
motion_set(random_range(-15, 15) + 90, 2);
friction = .05;

progress_max = .75 sec;
value = 0;

var range = 15;
x += random_range(-range, range);
y += random_range(-range, range);

var d = depth;
with effectStatGained d = min(d, depth);
depth = d - 1;