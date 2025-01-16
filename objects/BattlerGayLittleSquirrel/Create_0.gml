/// @description 

// Inherit the parent event
event_inherited();
set_hp(30)

//size = ENEMY_SIZE.SMALL;
movemode = moveOrder.LINEAR

with add_action("fart") {
	//var damage = range(4, 6);
	var range = new RangeProvider(4, 8);
	hit(as_damage(range));
	block(4);
}

with add_action("pee") {
	hit(as_damage(12));
}
