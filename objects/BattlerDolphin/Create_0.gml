/// @description 

// Inherit the parent event
event_inherited();
set_hp(40)

movemode = moveOrder.LINEAR
spr_icon = sprDolphinIcon

with add_action("Bet") {	
	var damage = as_damage(new FunctionProvider(mana_get_highest));
	set_intent(INTENT.ATTACK, damage)
	hit(damage)
	
	//freeze(4);

	desc = "Deal Damage equal to\n highest Mana count."
}