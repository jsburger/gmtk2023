function run_across_line(x1, y1, x2, y2, division, func, force_endpoint = true) {
	var dist = point_distance(x1, y1, x2, y2),
		dir = point_direction(x1, y1, x2, y2),
		travel = 0;
	func(x1, y1)
	var done = false;
	while true {
		travel += division;
		
		if travel > dist {
			if force_endpoint travel = dist
			else break
		}
		if travel == dist {
			done = true
		}
		
		func(x1 + lengthdir_x(travel, dir), y1 + lengthdir_y(travel, dir));
		if done break
	}
}