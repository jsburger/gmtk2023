/// @description 
draw_self();
draw_sprite_ext(character.spr_idle, 1, x + 32, y, .5, .5, 0, c_white, 1);
font_push(fntSmall, fa_right);
draw_text(bbox_right, y, character.name);
font_pop();