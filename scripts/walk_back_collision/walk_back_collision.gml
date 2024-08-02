function walk_back_collision(inst, collider) {
	with inst {
		var prev_dir = point_direction(x, y, xprevious, yprevious),
			tries = 0,
			dist = point_distance(x, y, xprevious, yprevious),
			len = min(dist, 1),
			walk_x = lengthdir_x(len, prev_dir),
			walk_y = lengthdir_y(len, prev_dir);
		while place_meeting(x, y, collider) && (tries++ < dist) {
			x += walk_x;
			y += walk_y;
		}
		return tries * len
	}
}