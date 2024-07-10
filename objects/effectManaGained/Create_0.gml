/// @description 
event_inherited()

motion_add(random(360), random_range(12, 16))

target = PlayerBattler;

distance_ref = distance_to_object(target);

needs_board = false;
friction = .5;
speedmax = 25;

color = -1;