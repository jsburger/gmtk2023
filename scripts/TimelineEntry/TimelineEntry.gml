function TimelineEntry() constructor {
	height = 0;
	alpha = 0;
	
	y = 0;
	ygoal = 0;
	initialized = false;
	
	static draw = function(draw_x, draw_y) {}
}

function TimelineEnemyMove(move) : TimelineEntry() constructor {
	height = 96;
	action = move;
	
	static draw = function(draw_x, draw_y) {
		draw_sprite_ext(sprIconBG, 0, draw_x, draw_y, 1, 1, snap_to(180 * dsin(current_frame * .2 + draw_y), 1), action.owner.bg_color, .75)
		draw_sprite(action.owner.spr_icon, sprite_get_animation_frame(action.owner.spr_icon), draw_x, draw_y);
		
		intent_draw(draw_x - 64, draw_y, action.intent, action.intent_value)
		
		if mouse_in_rectangle(draw_x - 32, draw_y - 32, draw_x + 32, draw_y + 32) {
			draw_textbox(draw_x + 32, draw_y, action.desc)
			action.owner.show_owner = true;
		}
	}
}