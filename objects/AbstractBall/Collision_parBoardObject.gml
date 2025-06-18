/// @description 
has_bounced = false;
var collider = other;
if image_blend = c_dkgray || !collider.can_collide exit;
if !place_meeting(x, y, other) exit; //Collisions are cached during the event, even if the ball moves.

// Walk back until not colliding any more
var walk_distance = 0,
	walk_start_x = x,
	walk_start_y = y;
if (collider.can_walk_back_ball) {
	walk_distance += walk_back_collision(self, collider);
}

//Perform ball_filter *after* walking back for positional accuracy with things like One-Ways
if !ball_filter(self, collider) {
	x = walk_start_x;
	y = walk_start_y;
	exit;
}


// Check for "surfaces" created by bricks
var collider_changed = false;
if instance_is(collider, parBrick) {
	// Check for outer bounds
	var left = x < collider.bbox_left,
		right = x > collider.bbox_right,
		top = y < collider.bbox_top,
		bottom = y > collider.bbox_bottom,
		horizontal = left || right,
		vertical = top || bottom;
	//Outside the brick's surface bounds
	if (horizontal && vertical) {
		//Horizontal check, colliding from the side;
		var side_inst = instance_position(left ? collider.bbox_left + 1 : collider.bbox_right - 1, 
			top ? collider.bbox_top - 1 : collider.bbox_bottom + 1,
			parBrick);
		if instance_exists(side_inst) && side_inst.can_collide && ball_filter(self, side_inst) {
			collider = side_inst
			collider_changed = true;
		}
		else {
			//Vertical Check, colliding from the top;
			var vert_inst = instance_position(
				left ? collider.bbox_left - 1 : collider.bbox_right + 1,
				top ? collider.bbox_top + 1 : collider.bbox_bottom - 1,
				parBrick);
			if instance_exists(vert_inst) && vert_inst.can_collide && ball_filter(self, vert_inst) {
				collider = vert_inst
				collider_changed = true;
			}
		}
	}
}

//Walk back again
if collider_changed {
	with collider collider = self; //Converts ID reference to Instance reference. Prevents crash.
	if (collider.can_walk_back_ball) {
		walk_distance += walk_back_collision(self, collider)
	}
}

// Take away acceleration from "after" the collision, it is given back later.
var taken_acceleration = 0;
if walk_distance > 0 {
	var factor = walk_distance/speed;
	taken_acceleration = previous_acceleration * factor;
	hspeed -= lengthdir_x(taken_acceleration, gravity_direction);
	vspeed -= lengthdir_y(taken_acceleration, gravity_direction);
}

// Reset variables
nograv = false;
extraspeed = 0;

//Todo: replace this
var collision = {
	x: clamp(x, collider.bbox_left, collider.bbox_right),
	y: clamp(y, collider.bbox_top, collider.bbox_bottom)
};

var damaged = false,
	pierced = true;
if damage > 0 && ball_can_damage(self, collider) {
	damaged = brick_hit(collider, damage, self);
	pierced = false;
}

var bounce = true;
	
//Try to pierce
if damaged {
	var infpierce = effects.can_infinite_pierce(self, collider);
	if (pierce > 0 || infpierce) && (collider.hp <= 0 || (is_ghost && collider.ghost_hp <= 0)) {
		bounce = false;
		if !infpierce {
			pierce -= 1;
		}
		pierced = true;
	}
}

//Bounce off
if bounce {
	collider.ball_bounce(self);
	on_bounce();
	has_bounced = true;
}

if walk_distance > 0 {
	x += lengthdir_x(walk_distance, direction);
	y += lengthdir_y(walk_distance, direction);
	//Restore acceleration taken after collisions are complete
	hspeed += lengthdir_x(taken_acceleration, gravity_direction);
	vspeed += lengthdir_y(taken_acceleration, gravity_direction);
}

if ball_can_damage(self, collider) {
	if !is_ghost {
		collider.on_ball_impact(self, collision.x, collision.y)
	}
	rolled_on_collider = collider.id;
	
	effects.on_impact(self, {
		collider,
		pierced
	})
	
	if !is_ghost && !is_coin && collider.is_burning {
		PlayerBattler.statuses.add_status(STATUS.BURN, 1)
		// Play Sound
		sound_play_pitch(sndFire, random_range(.8, 1.2));
	}
}

on_dice_bounce(self);