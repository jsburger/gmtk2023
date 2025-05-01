/// @description 
if throw_active() {
	draw_self();
	draw_sprite(attack ? sprIntentAttack : sprIntentDefend, 0, x - 32, y - 32);
	font_push(fntBig, fa_left, fa_bottom);
	draw_text(x, y, string(attack ? global.mana_effects.attack : global.mana_effects.block));
	font_pop();
}