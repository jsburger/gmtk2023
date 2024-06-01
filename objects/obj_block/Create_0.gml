event_inherited();
image_index = irandom(image_number);
my_health = 1;
is_destructible = true;
drop_chance = 9;
drop_amount = 1;
nexthurt = current_time;

colorable = true
color = -1
mana_amount = 1
set_color = function(col) {
	if !in_range(col, -1, MANA.MAX - 1) exit
	color = col
	//Dearest Kram, you may replace these with honest recolors if you would like. I was in a hurry.
	switch col {
		case -1:
			image_blend = c_white
			break
		case MANA.RED:
			image_blend = #d12222
			break
		case MANA.BLUE:
			image_blend = #4566d1
			break
		case MANA.YELLOW:
			image_blend = #efc555
			break
	}
}



if instance_exists(obj_board) {
	visible = false
	alarm[0] = obj_board.editor ?  1 : manhatten_distance(x, y, obj_board.bbox_left, obj_board.bbox_top)/32
}

if random(10) < 1 && color == -1 && !obj_board.editor && (object_index == obj_block || object_index == obj_block_large) {
	set_color(MANA.YELLOW);
}

if random(60) < 1 && !obj_board.editor && object_index == obj_block{
	instance_create_layer(x,y,"Instances",obj_super_block);
	drop_chance = 0;
	instance_destroy();
}
if random(120) < 1 && !obj_board.editor && object_index == obj_block{
	instance_create_layer(x,y,"Instances",obj_block_gold);
	drop_chance = 0;
	instance_destroy();
}
image_xscale = choose(-1, 1);



serialize = function() {
	if colorable {
		return {
			"color": color
		}
	}
	return undefined
}
deserialize = function(struct) {
	var c = struct.color;
	if in_range(c, -1, MANA.MAX - 1) {
		set_color(struct.color)
	}
}