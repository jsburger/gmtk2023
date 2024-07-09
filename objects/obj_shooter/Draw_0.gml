
{
	draw_self()
	if has_dice {
		if can_act() draw_dice_preview(x, y, gunangle);
		draw_sprite(sprDiceIdle, -1, x, y);
	}
}
