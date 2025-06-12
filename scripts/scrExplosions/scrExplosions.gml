function Explosion(_x, _y, _source, _radius, _damage, _force = 12) constructor {
	radius = _radius;
	force = _force;
	damage = _damage;
	source = _source;
	x = _x;
	y = _y;
	
	static act = function() {
		with parBoardObject if can_take_damage && distance_to_bbox(other.x, other.y, self) < other.radius {
			brick_hit(self, other.damage, other.source);
		}
		with AbstractBall if distance_to_bbox(other.x, other.y, self) < other.radius {
			motion_set(point_direction_struct(other, self), other.force);
		}
	}
}

/// Queues a given explosion to occur next step
/// @param {Struct.Explosion} explosion
function explode(explosion) {
	if !instance_exists(Exploder) instance_create_depth(0, 0, 0, Exploder);
	Exploder.enqueue(explosion);
}