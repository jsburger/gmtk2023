/// @description 

// Inherit the parent event
event_inherited();
set_hp(40)

movemode = moveOrder.LINEAR
spr_icon = sprDolphinIcon

with add_action("Bet") {	
	var damage = as_damage(new FunctionProvider(mana_get_highest));
	add_intent(new Intent(sprIntentAttack, damage))
		.with_desc("Deal Damage equal to\n highest Mana count.");
	hit(damage)
	
	//freeze(4);
}