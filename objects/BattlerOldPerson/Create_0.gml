/// @description 

// Inherit the parent event
event_inherited();
set_hp(25)

movemode = moveOrder.RANDOM_STACK
spr_icon = sprOldPersonIcon
size = ENEMY_SIZE.SMALL;

var reduce = function(){
	mana_subtract_all(2)
}

with add_action("Lose") {
	var damage = new DamageProvider(6, other, TARGETS.PLAYER)
	accept_provider(damage)
	set_intent(INTENT.ATTACK, damage)
	hit(damage)
	recolor(6, MANA_NONE)	

	desc = "Deal 6 Damage.\nUncolor 6 Bricks."
}

with add_action("Drain") {
	set_intent(INTENT.DEBUFF, 2)
	run(reduce);
	buff_strength(2);
	desc = "Reduce all Mana by 2\nGain 2 Strength."
}
