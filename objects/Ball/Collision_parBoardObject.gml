/// @description 
has_bounced = false;
var collider = other;
if image_blend = c_dkgray || !collider.can_collide exit;
if !ball_filter(self, collider) exit;

// Walk back until not colliding any more
if (collider.can_walk_back_ball) {
	var prev_dir = point_direction(x, y, xprevious, yprevious),
		walk_x = lengthdir_x(1, prev_dir),
		walk_y = lengthdir_y(1, prev_dir),
		tries = 0,
		dist = point_distance(x, y, xprevious, yprevious);
	while place_meeting(x, y, collider) && (tries++ < dist) {
		x += walk_x;
		y += walk_y;
	}
}
// Check for "surfaces" created by bricks
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
		//Horizontal check;
		var side_inst = instance_position(x, top ? collider.bbox_top - 1 : collider.bbox_bottom + 1, parBrick);
		if instance_exists(side_inst) && side_inst.can_collide && ball_filter(self, side_inst) {
			collider = side_inst
		}
		else {
			//Vertical Check;
			var vert_inst = instance_position(left ? collider.bbox_left - 1 : collider.bbox_right + 1, y, parBrick);
			if instance_exists(vert_inst) && vert_inst.can_collide && ball_filter(self, vert_inst) {
				collider = vert_inst
			}
		}
	}
}

// Reset variables
nograv = false;
extraspeed = 0;

//Todo: replace this
var collision = {
	x: clamp(x, collider.bbox_left, collider.bbox_right),
	y: clamp(y, collider.bbox_top, collider.bbox_bottom)
};

var damaged = false;
if damage > 0 && !is_ghost {
	damaged = brick_hit(collider, damage, self);
}

var bounce = true;
//Try to pierce
if damaged {
	if pierce > 0 && collider.hp <= 0 {
		bounce = false;
		pierce -= 1;
	}
}
//Ghost piercing
if (is_ghost && !collider.ghost_immune) collider.ghost_hits += 1;

if bounce && is_ghost && collider.can_take_damage {
	if pierce > 0 && (((collider.hp / damage) + collider.is_frozen) <= collider.ghost_hits) {
		//array_push(ghost_pierce_list, collider.id);
		pierce -= 1;
		bounce = false;
	}
}


//Bounce off
if bounce {
	collider.ball_bounce(self);
}

if !is_ghost collider.on_ball_impact(self, collision.x, collision.y)

on_dice_bounce(self);
has_bounced = true;