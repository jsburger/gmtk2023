draw_self()
if has_dice {
	if can_act() && mouse_in_bbox(Board) draw_dice_preview(x, y, gunangle, throw_speed);
	draw_sprite_auto(spr_dice, x, y);
}