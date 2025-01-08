/// @description 

var _x = x
x += 50 * lean
if !(ability.can_cast()) {
	image_blend = c_ltgray;
}
draw_self()
image_blend = c_white;

if ability != undefined {
	draw_sprite_ext(ability.sprite_index, sprite_get_animation_frame(ability.sprite_index), bbox_left + 32, y, ability.image_xscale, ability.image_yscale, 0, c_white, 1)
	
	font_push(fntSmall)
	draw_text(bbox_left + 64, y - 24, ability.name)
	draw_text(bbox_left + 64, y + 8, ability.desc)
	if ability.uses != infinity draw_text(bbox_right - 24, bbox_top + 12, ability.uses);
	font_pop()
	
	var count = 0,
		costs = ability.modified_costs.get();
	for (var i = 0; i < array_length(costs); i++) {
		if costs[i] > 0 {
			draw_number_panel(lerp(bbox_left, bbox_right, count/array_length(costs)), bbox_top,
				string(costs[i]), mana_get_color(i), 2, .5
			)
			count++
		}
	}
	
	//draw_text(bbox_left, bbox_top - 8, string(ability.position))
}
x = _x