enum TIMELINE_ORDER {
	TOP,
	MOVES,
	AFTER_MOVES
}

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
		draw_sprite_ext(sprIconBg, 0, draw_x, draw_y, 1, 1, snap_to(180 * dsin(current_frame * .2 + draw_y), 1), action.owner.bg_color, .75)
		draw_sprite(action.owner.spr_icon, sprite_get_animation_frame(action.owner.spr_icon), draw_x, draw_y);
		
		intent_draw(draw_x - 64, draw_y, action.intent, action.intent_value)
		
		if mouse_in_rectangle(draw_x - 32, draw_y - 32, draw_x + 32, draw_y + 32) {
			draw_textbox(draw_x - 64, draw_y - 48, action.desc)
			action.owner.show_owner = true;
		}
	}
}

function TimelineBoardNote(sprite, desc) : TimelineEntry() constructor {
	height = 96;
	highlight_object = undefined;
	bg_color = c_dkgray;
	self.sprite = sprite;
	self.desc = desc;
	
	static draw = function(draw_x, draw_y) {
		draw_sprite_ext(sprIconBg, 0, draw_x, draw_y, 1, 1, snap_to(180 * dsin(current_frame * .2 + draw_y), 1), bg_color, .75)
		draw_sprite(sprite, sprite_get_animation_frame(sprite), draw_x, draw_y)
		
		if mouse_in_rectangle(draw_x - 32, draw_y - 32, draw_x + 32, draw_y + 32) {
			draw_textbox(draw_x - 64, draw_y - 48, desc)
			if highlight_object != undefined with highlight_object {
				var top = bbox_top + 3 * dsin(current_frame + draw_y);
				draw_set_color(c_red)
				var width = 32,
					height = 12,
					stem_width = 14,
					stem_height = 24;
				draw_triangle(x, top, x - width/2, top - height, x + width/2, top - height, false)
				draw_rectangle(x - stem_width/2, top - height + 1, x + stem_width/2, top - height - stem_height, false)
				draw_set_color(c_white)
			}
		}
	}
}