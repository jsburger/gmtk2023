/// @description bounce off this mfer
// You can write your code in this editor
var collider = other;
if image_blend = c_dkgray || !collider.can_collide exit;

// Walk back until not colliding any more
var prev_dir = point_direction(x, y, xprevious, yprevious),
	walk_x = lengthdir_x(1, prev_dir),
	walk_y = lengthdir_y(1, prev_dir),
	tries = 0,
	dist = point_distance(x, y, xprevious, yprevious);
while place_meeting(x, y, collider) && (tries++ < dist) {
	x += walk_x;
	y += walk_y;
}
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
	var side_inst = instance_position(x, top ? collider.bbox_top - 1 : collider.bbox_bottom + 1, obj_block);
	if instance_exists(side_inst) && side_inst.can_collide {
		collider = side_inst
	}
	else {
		//Vertical Check;
		var vert_inst = instance_position(left ? collider.bbox_left - 1 : collider.bbox_right + 1, y, obj_block);
		if instance_exists(vert_inst) && vert_inst.can_collide {
			collider = side_inst
		}
	}
}


var collision = {x: clamp(x, collider.bbox_left, collider.bbox_right), y: clamp(y, collider.bbox_top, collider.bbox_bottom)};

var dir = point_direction(collision.x,collision.y, x, y);

if pierce <= 0 or !collider.is_destructible or (collider.my_health > damage) {
	motion_add(dir, vector_get_length_on_axis(speed, direction, dir + 180) * 2)
}
else {
	pierce--;	
}

nograv = false;

if vspeed < 0 && speed > 2 vspeed = min(vspeed, -4);

instance_create_layer(collision.x, collision.y, "FX", obj_hit_small);
on_dice_bounce(self);

var _metal = !collider.is_destructible;
sound_play_pitch(_metal ? snd_hitmetal : snd_die_hit_peg, _metal ? 1.6 * random_range(0.8, 1.2): random_range(0.8, 1.2));

if collider.object_index == obj_coin_pouch{

	sound_play_pitch(collider.my_health > 1 ? snd_bag_hit : snd_bag_open, random_range(1.2, 1.4));

	repeat(3){
		with instance_create_layer(collider.x, collider.bbox_top - 13, "Instances", obj_coin){
			motion_set(random_range(70, 110), irandom_range(5, 8));
		}
	}	
	if !irandom(9) with instance_create_layer(choose(bbox_left - 8, bbox_right + 8), y, "Instances", obj_tooth){
		motion_set(random_range(70, 110), irandom_range(3, 5));
	}
	
	with collider{
		switch sprite_index {
			case spr_bag_idle_a: sprite_index = spr_bag_hurt_a; break;
			case spr_bag_idle_b: sprite_index = spr_bag_hurt_b; break;
		}

		image_index = 0;
	}
}


if collider.is_destructible{
	has_bounced = true;
	collider.my_health -= damage;
	if collider.my_health <= 0{
		instance_destroy(collider);
	}
}


extraspeed = 0;