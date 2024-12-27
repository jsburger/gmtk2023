/// @description 

// Inherit the parent event
event_inherited();
set_hp(35)

movemode = moveOrder.RANDOM_STACK
spr_icon = sprOldPersonIcon
size = ENEMY_SIZE.SMALL;

var reduce = function(){
	mana_subtract_all(4)
}

with add_action("Lose") {
	var damage = new DamageProvider(6, other, TARGETS.PLAYER)
	accept_provider(damage)
	set_intent(INTENT.ATTACK, damage)
	hit(damage)

	desc = "Deal 6 Damage."
}

with add_action("Drain") {
	set_intent(INTENT.DEBUFF)
	recolor(6, MANA_NONE)	
	buff_strength(2);
	desc = "Uncolor 6 Bricks.\nGain 2 Strength."
}
