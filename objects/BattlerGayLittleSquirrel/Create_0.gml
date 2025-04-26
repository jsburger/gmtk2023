/// @description 

// Inherit the parent event
event_inherited();
set_hp(30)

//size = ENEMY_SIZE.SMALL;
movemode = moveOrder.LINEAR

add_action("fart", function() {
	MOVESTART
	//var damage = range(4, 6);
	var range = new RangeProvider(4, 8);
	hit(as_damage(range));
	block(4);
	MOVEEND
})

add_action("pee", function() {
	MOVESTART
	hit(as_damage(12));
	MOVEEND
})