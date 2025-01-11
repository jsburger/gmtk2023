/// @description 

var _x = y;
y += 20 * lean
draw_self()

if encounter != undefined {

	font_push(fntSmall, fa_center)
	draw_text((bbox_left + bbox_right)/2, y - 24, encounter.name)
	font_pop()
	
	if can_draw_enemy {
		var enemies = encounter.enemies;
		for (var i = 0; i < array_length(enemies); i++) {
			var object = enemies[i];
			if is_array(object) object = object[0];
			var sprite = object_get_sprite(object);
			draw_sprite_ext(
				sprite, 0,
				bbox_right - 32 * i - 24, bbox_bottom - 24,
				.4, .4, 0, c_white, 1)
		}
	}
}
y = _x