/// @description Stay inside board
// You can write your code in this editor

//True when bouncing

if (instance_exists(Board)) {
	if bbox_bottom > Board.bbox_bottom{
		if (touchedBottom){
			if bbox_bottom > Board.bbox_bottom + 128{
				instance_destroy()
			}
		}
		else {
			touchedBottom++;
			y = yprevious;
			vspeed = board_bottom_bounce;
			landed = true;
			alarm[0] = 1;
		}
	}
}