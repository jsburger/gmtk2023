/// @description 

// Inherit the parent event
event_inherited();
shuffle;

spr_idle = sprPortalLipsIdle
spr_open = sprPortalLipsOpen
spr_close = sprPortalLipsClose

index = 0;
spr_back = sprPortalBackPurple
spr_fx = sprFXPortalPurple

set_index = function(i) {
	index = i;
	vars_apply(portal_get_sprites(i));
}

serializer.add_layer("portal_index", function() {return index}, set_index)

can_ball_collide = function(ball) {
	return ball.portal != id;
}

can_walk_back_ball = false;
stops_preview = false;

last_target = noone;
ball_bounce = function(ball) {
	var target = noone;
	with Portal if id != other.id {
		if index = other.index {
			target = self;
		}
	}
	
	if instance_exists(target) {
		last_target = target;
		ball.x = target.x;
		ball.y = target.y;
		ball.portal = target.id;
	}
}

on_ball_impact = function(ball, collision_x, collision_y) {
	sprite_change(spr_close)
	with last_target sprite_change(spr_open)
}
