function sleep(ms) {
	var goal = current_time + ms;
	var i = 0;
	while (current_time < goal) {
		i += 1;
	}
}