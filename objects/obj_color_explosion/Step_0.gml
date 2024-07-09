/// @description Color Splat Crap

frame += 1;

if frame < 10 {
	with (instance_create_depth(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), depth - 100, obj_fx)) {
		sprite_index = sprFXSplat
		
		var rand_scale = random_range(0.5, 1.5);
		image_xscale = rand_scale;
		image_yscale = rand_scale;
		image_blend = mana_get_color(other.color);
	}
}