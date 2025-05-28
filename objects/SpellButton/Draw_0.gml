/// @description 

var _x = x,
	scale = image_xscale;
//x += 50 * lean
if !(spell.can_cast()) {
	image_blend = c_ltgray;
}
if spell != undefined {
	font_push(fntSmall)
	image_xscale += ((string_width(spell.desc) + 8)/sprite_get_width(sprite_index)) * lean;
	font_pop()
}

if (hovered || active) { stencil_setup_write(1); }
draw_self()
image_blend = c_white;

if (hovered || active) { stencil_disable(); }

if spell != undefined {

	if hovered || active {
		stencil_setup_read()
	
		font_push(fntSmall)
		draw_text(bbox_left + 64, y - 24, spell.name)
		draw_text(bbox_left + 64, y + 8, spell.desc)
		font_pop()
	
		stencil_disable();
	}
	
	draw_sprite_auto(spell.sprite_index, bbox_left + 32, y)
	
	var count = 0,
		costs = spell.modified_costs.get();
	for (var i = 0; i < array_length(costs); i++) {
		if costs[i] > 0 {
			//var enough = global.mana[i] >= costs[i];
			draw_number_panel_ra(bbox_left - 8, lerp(bbox_top, bbox_bottom, count/array_length(costs)) + 12,
				string(costs[i]), mana_get_color(i), undefined, .5
			)
			count++
		}
	}
	var col = merge_color(c_maroon, c_ltgray, .5)
	if spell.uses != infinity draw_number_panel(bbox_right, bbox_top + 12, string(spell.uses), col, undefined, .5);
	
	//draw_text(bbox_left, bbox_top - 8, string(spell.position))
}
x = _x
image_xscale = scale;