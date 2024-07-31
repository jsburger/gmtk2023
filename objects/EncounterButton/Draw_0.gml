/// @description 

var _x = y
y += 20 * lean
draw_self()

if encounter != undefined {
	//draw_sprite(ability.sprite_index, sprite_get_animation_frame(ability.sprite_index), bbox_left + 32, y)
	draw_set_color(c_black)
	draw_set_halign(fa_center)
	draw_text((bbox_left + bbox_right)/2, y - 24, encounter.name)
	//draw_text(bbox_left + 64, y + 8, ability.desc)
	draw_set_color(c_white)
	draw_set_halign(fa_left)
	
}
y = _x