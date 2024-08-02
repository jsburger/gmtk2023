function arc_length_to_degrees(length, radius) {
	//(2 * pi * r) * (degrees/360) = length
	//(degrees/360) = length/(2 * pi * r)
	//degrees = length/(2 * pi * r) * 360
	return (length/(2 * pi * radius)) * 360;
}