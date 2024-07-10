event_inherited();
image_index = irandom(image_number);
my_health = 1;
is_destructible = true;
drop_chance = 9;
drop_amount = 1;
nexthurt = current_time;

#region Coloring
	colorable = true
	color = -1
	mana_amount = 1
	set_color = function(col) {
		if !in_range(col, MANA_NONE, MANA.MAX - 1) exit
		color = col
		//Dearest Kram, you may replace these with honest recolors if you would like. I was in a hurry.
		switch col {
			case MANA_NONE:
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
#endregion

#region Freezing
	freezable = true;
	spr_frozen = sprBrickOverlayFrozen;
	spr_frozen_index = 0;
	frozen = false;
	/// Cleaning prevents the function from calling brick_unfreeze, which would create a loop
	set_frozen = function(value, cleaning = false) {
		if value != frozen {
			frozen = value;
			if frozen {
				spr_frozen_index = irandom(sprite_get_number(spr_frozen) - 1);
			}
			else if !cleaning {
				brick_on_unfreeze(self)
			}
		}
	}
	
	//Hack
	if (string_pos("block", string_lower(object_get_name(object_index))) == 0) freezable = false;
#endregion

if instance_exists(obj_board) {
	visible = false
	alarm[0] = obj_board.editor ?  1 : manhatten_distance(x, y, obj_board.bbox_left, obj_board.bbox_top)/32
}

if random(10) < 1 && color == -1 && !obj_board.editor && (object_index == obj_block || object_index == obj_block_large) {
	set_color(MANA.YELLOW);
}

// Block replacements
if chance(1, 60) && !obj_board.editor && object_index == obj_block{
	instance_create_layer(x,y,"Instances",obj_super_block);
	drop_chance = 0;
	instance_destroy();
}
if chance(1, 120) && !obj_board.editor && object_index == obj_block{
	instance_create_layer(x,y,"Instances",obj_block_gold);
	drop_chance = 0;
	instance_destroy();
}

image_xscale = choose(-1, 1);


#region Serialize
	serialize = function() {
		if colorable && color > -1 {
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
#endregion