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

can_walk_back_ball = false;
last_target = noone;
ball_bounce = function(ball) {
	var target = noone;
	with Portal if id != other.id {
		if index = other.index {
			target = self;
		}
	}
	
	if instance_exists(target) && ball.portal != target.id {
		last_target = target;
		ball.x = target.x;
		ball.y = target.y;
		ball.portal = target.id;
		ball.just_portal = true;
	}
}

on_ball_impact = function(ball, collision_x, collision_y) {
	if ball.just_portal {
		ball.just_portal = false;
		
		sprite_change(spr_close)
		with last_target sprite_change(spr_open)
	}
}

teleport = function(instance, portal = self) {
	var target = noone;
	with Portal {
		if (index == portal.index && id != portal.id)
			target = self;
	}
	
	if instance.object_index != obj_fx {
		portal.sprite_index = portal.spr_close;
		portal.image_index = 0;
		target.sprite_index = target.spr_open;
		target.image_index = 0;
	}
	
	if instance_exists(target) {
		if instance.portal != id {
			instance.x = target.x;
			instance.y = target.y;
			instance.portal = target.id;
			return true
		}
	}
	return false
}
