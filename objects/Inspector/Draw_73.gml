/// @description 
if fade > 0 {
	
	stencil_setup_write(2);
	
	if instance_exists(inspected) {
		var text = inspected.inspect_text();
		if array_length(text) > 0 {
			with inspected event_perform(ev_draw, ev_draw_normal);
		}	
	}
	draw_sprite_auto(sprInspectCursor, mouse_x, mouse_y);
	
	stencil_setup_avoid();
	
	draw_rectangle_simple(cam_x, cam_y, cam_right, cam_bottom, c_black, .5 * fade);
	
	stencil_disable();
	
	if instance_exists(inspected) {
		
		font_push(fntSmall);
		draw_set_color(c_white);
		draw_textbox(inspected.bbox_right + 32, inspected.bbox_top - 32, text);
		font_pop();
	}
}