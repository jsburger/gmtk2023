/// @description
x1 = 0;
y1 = 0;
x2 = 0;
y2 = 0;
xmid = 0;
ymid = 0;
mouse_found = false;
hovered = false

get_info = function(i) {
	var size = 120,
		gap = 8,
		gridsize = 5,
		xpos = (i mod gridsize),
		ypos = (i div gridsize);
	x1 = xpos * (size + gap) + board_left;
	y1 = ypos * (size + gap) + board_top;
	x2 = x1 + size;
	y2 = y1 + size;
	xmid = x1 + size/2;
	ymid = y1 + size/2;
	if (!mouse_found) {
		if mouse_in_rectangle(x1, y1, x2, y2) {
			mouse_found = true;
			hovered = true;
		}
	}
	else {
		hovered = false;
	}
}