global.abilitykeys = {};
#macro SPELLS global.abilitykeys

// Dont make a million of these, I still need to add a prototype system. Like the technical kind of prototype.

#region Placers
	SPELLS.PLACE_BOMB = register_ability("PlaceBomb", function() {
		with new AbilityPlacer(Bomb) {
			name = "Bomb Placer"
			desc = "Place a Bomb"
			sprite_index = sprBomb
			set_costs(12, 4, 0)
			return self
		}
	})

	SPELLS.PLACE_BRICK = register_ability("PlaceBlock", function() {
		with new AbilityPlacer(BrickNormal) {
			name = "Block Placer"
			desc = "Place a Block"
			sprite_index = sprBrick
			set_cost(MANA.BLUE, 1)		
			return self
		}
	})
	SPELLS.PLACE_BARREL = register_ability("PlaceBarrel", function() {
		with new AbilityPlacer(Barrel) {
			name = "Barrel Placer"
			desc = "Place a Barrel"
			can_rotate = true;
			rotation = 45;
			sprite_index = sprBarrel
			set_cost(MANA.YELLOW, 2)	
			return self
		}
	})
	
	SPELLS.REDIFY = register_ability("Recolor", function() {
		with new Ability(TARGET_TYPE.NONE) {
			name = "Redify"
			desc = "Redify 8 bricks"
			set_costs(3, 0, 1)
			sprite_index = new Sprite(sprPortraitBg).scale(.35);
			sprite_index.image_blend = c_red;
		
			act = function(runner) {
				recolor(8, COLORS.RED)
			}
		
			return self;
		}
	})
	
	SPELLS.REVIVE = register_ability("Revive", function() {
		with new Ability(TARGET_TYPE.NONE) {
			name = "Revive";
			desc = "Respawn 10 bricks";
			set_costs(1, 1, 1);
			sprite_index = new Sprite(sprPortraitBg).scale(.35);
			sprite_index.image_blend = merge_color(c_lime, c_gray, .7);
			
			act = function(runner) {
				consume(new RespawnItem(owner, 10))
			}
			
			return self;
		}
	})
	
#endregion

#region Attacks
	SPELLS.SLAMMY = register_ability("Hit6", function() {
		with new AbilityAttack(6) {
			set_costs(0, 8, 0);
			set_uses(2);
			name = "Slammy"
			desc = "Deal 6 damage to targeted enemy"
			sprite_index = sprIntentAttack		
			return self
		}
	})

	SPELLS.BIG_SLAMMY = register_ability("Hit24", function() {
		with new AbilityAttack(24) {
			set_uses(2);
			set_costs(0, 16, 8)
			name = "Slammy Senior"
			desc = "Deal 24 damage to targeted enemy"
			sprite_index = sprIntentAttack
			return self
		}
	})

	SPELLS.BLOCKO = register_ability("Block6", function() {
		with new AbilityDefend(6) {
			set_costs(8, 0, 0);
			set_uses(2);
			name = "Blocko"
			desc = "Gain 6 Block"
			sprite_index = sprIntentDefend		
			return self
		}
	})
#endregion