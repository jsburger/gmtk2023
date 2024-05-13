/// @description Color Splat Crap

frame += 1;

if frame < 10 {
	with (instance_create_depth(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), depth - 100, obj_fx)) {
		sprite_index = spr_splat
		var rand_scale = random_range(0.5, 1.5);
		image_xscale = rand_scale;
		image_yscale = rand_scale;
	
		switch other.color {
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
}