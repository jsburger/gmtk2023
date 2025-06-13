function GoblinCharacter() : Character("Goblin") constructor {
	set_sprites(sprGoblinIdle, sprGoblinShoot);
	
	bg_color = merge_color(c_green, c_gray, .6);
	
	starting_spells = [SPELLS.SLAMMY, SPELLS.BLOCKO, SPELLS.REDIFY, SPELLS.REVIVE];
	
	shooter = CuffsShooter;
	ball = PlayerBall;
	
	static modify_level_brick = function(input) {
		switch input {
			case BrickNormal:
			case BrickNormalV:
				return PegSmall;
			case BrickLarge:
			case BrickLargeV:
				return PegNormal;
			case BrickMetal:
			case BrickLargeMetal:
			case BrickLargeMetalV:
				return PegMetal;
		}
		return input;
	}
}