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
image_blend = c_white;

activate = function() {
	active = true;
	sprite_index = spr_found;
	sound_play_random(sndBill2);
}



on_throw_end = function() {
	static nearest = new FrameCache(function() {
		var dist = infinity,
			nearest = noone;
		with BrickHidden if active {
			var d = manhatten_distance(board_left, board_top, x, y);
			if d < dist {
				dist = d;
				nearest = self
			}
		}
		return {x: nearest.x, y: nearest.y}
	});
	
	if active {
		with instance_create_layer(x, y, layer, spawn_object) {
			if colorable {
				set_color(other.color);
			}
			var point = nearest.get();
			alarm[0] = manhatten_distance(point.x, point.y, x, y)/32 + 1;
		}
		instance_destroy(self)
	}
}