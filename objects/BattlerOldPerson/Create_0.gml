/// @description 

// Inherit the parent event
event_inherited();
set_hp(25)

movemode = moveOrder.RANDOM_STACK
spr_icon = sprOldPersonIcon
size = ENEMY_SIZE.SMALL;

with add_action("Lose") {
	var damage = 4;
	set_intent(INTENT.ATTACK, damage)
	hit(damage)
	recolor(6, MANA_NONE)	

	desc = "Deal 4 Damage.\nUncolor 6 Bricks."
}

with add_action("Drain") {
	set_intent(INTENT.DEBUFF)
	mana_reset_one(mana_get_highest);
	desc = "Reduce highest Mana to 0"
}
