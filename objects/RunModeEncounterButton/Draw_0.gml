/// @description 
draw_self();

var text = encounter == undefined ? "Missing Encounter" : encounter.name;
font_push(fntSmall, fa_center);
draw_text(x, y, text)

if encounter != undefined {
	gpu_set_fog(true, c_dkgray, 0, 0);
	var enemies = encounter.enemies, l = array_length(enemies);
	for (var i = 0; i < l; i++) {
		var object = enemies[i];
		if is_array(object) object = object[0];
		var sprite = object_get_sprite(object);
		var pos = (l == 1 ? .5 : i/(l - 1));
		draw_sprite_ext(
			sprite, 0,
			lerp(bbox_right - 48, bbox_left + 48, pos), y - 64,
			1, 1, 0, c_white, 1)
	}
	gpu_set_fog(false, c_white, 0, 0);
}

font_pop();