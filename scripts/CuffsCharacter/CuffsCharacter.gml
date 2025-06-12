/// @ignore
function CuffsCharacter() : Character("Cuffs") constructor {
	set_sprites(sprNewCuffsIdle, sprNewCuffsActive);
	shooter = CuffsShooter;
	
	bg_color = color_multiply(merge_color(c_blue, c_aqua, .5), c_ltgray);
	
	starting_spells = [
		SPELLS.SLAMMY, SPELLS.BLOCKO,
		SPELLS.PLACERS.BOMB, SPELLS.PLACERS.BARREL,
		SPELLS.REDIFY, SPELLS.REVIVE
	]
	
	ball = CuffsBall;
}