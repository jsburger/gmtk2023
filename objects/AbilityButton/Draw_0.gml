/// @description 

var _x = x
x += 50 * lean
draw_self()

if ability != undefined {
	draw_sprite_ext(ability.sprite_index, sprite_get_animation_frame(ability.sprite_index), bbox_left + 32, y, ability.image_xscale, ability.image_yscale, 0, c_white, 1)
	draw_set_color(c_black)
	draw_text(bbox_left + 64, y - 24, ability.name)
	draw_text(bbox_left + 64, y + 8, ability.desc)
	draw_set_color(c_white)
	
	var colors = [c_red, c_blue, c_yellow],
		count = 0
	for (var i = 0; i < array_length(ability.costs); i++) {
		if ability.costs[i] > 0 {
			draw_number_panel(lerp(bbox_left, bbox_right, count/array_length(ability.costs)), bbox_top,
				string(ability.costs[i]), colors[i], 2, .5
			)
			count++
		}
	}
}
x = _x