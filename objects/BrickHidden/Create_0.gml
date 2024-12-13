/// @description 

// Inherit the parent event
event_inherited();

drops_gibs = false;

can_take_damage = false;
can_walk_back_ball = false;
fullclear_forced = true;
colorable = true;
can_collide = false;

spr_found = sprBrickHiddenFound;
active = false;
spawn_object = BrickNormal;
dying = false;
image_blend = c_white;

activate = function() {
	active = true;
	sprite_index = spr_found;
	sound_play_random(sndBill2);
}

activation_time = function(need_active) {
	static nearest = new FrameCache(function(need_active) {
		var dist = infinity,
			nearest = noone;
		with BrickHidden if (!need_active || active) && dying == false {
			var d = manhatten_distance(board_left, board_top, x, y);
			if d < dist {
				dist = d;
				nearest = self
			}
		}
		return {x: nearest.x, y: nearest.y}
	});
	var point = nearest.get(need_active);
	return manhatten_distance(x, y, point.x, point.y)/32 + 1;
}

do_it = function(need_active) {
	if dying return -1;
	
	var time = activation_time(need_active);
	with instance_create_layer(x, y, layer, spawn_object) {
		if colorable {
			set_color(other.color);
		}
			
		alarm[0] = time;
	}
	alarm[1] = time;
	dying = true;
	return time;
}

on_round_start = function() {
	if board_is_last_round() {
		var t = do_it(false);
		with CombatRunner waitTime = max(t, waitTime);
	}
}

on_throw_end = function() {	
	if active {
		do_it(true);
	}
	
}