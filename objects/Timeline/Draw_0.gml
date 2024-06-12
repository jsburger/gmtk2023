/// @description 

var enemies = CombatRunner.enemies;

var draw_x = x,
	draw_y = y;
for (var i = 0; i < array_length(enemies); i++) {
	var enemy = enemies[i];
	if enemy.canact && enemy.current_action != undefined {
		draw_sprite(enemy.spr_icon, sprite_get_animation_frame(enemy.spr_icon), draw_x, draw_y);
		
		intent_draw(draw_x - 64, draw_y, enemy.current_action.intent, enemy.current_action.intent_value)
		
		if mouse_in_rectangle(draw_x - 32, draw_y - 32, draw_x + 32, draw_y + 32) {
			draw_textbox(draw_x + 32, draw_y, enemy.current_action.desc)
		}
		draw_y += 96
	}
}