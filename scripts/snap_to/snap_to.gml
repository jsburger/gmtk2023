function snap_to(n, snap) {
	return round(n / snap) * snap
}

function snap_to_lowest(n, snap) {
	return floor(n / snap) * snap;
}

function snap_to_highest(n, snap) {
	return ceil(n/snap) * snap;
}