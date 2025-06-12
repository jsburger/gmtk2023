/// @param {String} name
/// @param {Function} spellFactory
function register_spell(name, spellFactory) {
	static spells = ds_map_create();
	ds_map_add(spells, name, spellFactory)
	return name;
}

/// @param {String} name
/// @returns {Struct.Spell, Undefined}
function spell_get(name) {
	var proto = register_spell.spells[? name];
	if proto == undefined return undefined;
	// Feather disable once GM1045
	return proto() ?? Spell.last_spell;
}

global.spellkeys = {};
#macro SPELLS global.spellkeys

#region Placers
	SPELLS.JUNO = get_juno_spells();
	SPELLS.PLACERS = {};
	SPELLS.PLACERS.BOMB = register_spell("PlaceBomb", function() {
		with new PlacerSpell(Bomb) {
			name = "Bomb Placer"
			desc = "Place a Bomb"
			sprite_index = sprBomb
			set_costs(12, 4, 0)
			return self
		}
	})

	SPELLS.PLACERS.BARREL = register_spell("PlaceBarrel", function() {
		var placer = new LauncherPlacer(Barrel, 45);
		placer.rotation_speed = 90;
		
		with new PlacerSpell(placer) {
			name = "Barrel Placer"
			desc = "Place a Barrel"
			sprite_index = sprBarrel
			set_cost(MANA.YELLOW, 2)
			return self
		}
	})
	
	SPELLS.PLACERS.DEMON_ORB = register_spell("PlaceOrb", function() {
		with new PlacerSpell(DemonOrb) {
			name = "Summon Demon";
			desc = "Place a Demon Orb, which colors nearby bricks Purple.";
			set_costs(2, 2, 2);
			sprite_index = sprDemonOrb;
			return self;
		}
	})
	
	SPELLS.REDIFY = register_spell("Redify", function() {
		with new InstantSpell() {
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
	
	SPELLS.REVIVE = register_spell("Revive", function() {
		with new InstantSpell() {
			name = "Revive";
			desc = "Respawn 10 bricks";
			set_costs(1, 1, 1);
			sprite_index = new Sprite(sprPortraitBg).scale(.35);
			sprite_index.image_blend = merge_color(c_lime, c_gray, .7);
			
			act = function(runner) {
				consume(new RespawnItem(owner, 10))
			}
			
			can_cast_modifier = function() {
				return (array_length(global.dead_bricks) > 0);
			}
			
			return self;
		}
	})
	
#endregion

#region Attacks
	SPELLS.SLAMMY = register_spell("Hit6", function() {
		with new AttackSpell(6) {
			set_costs(0, 8, 0);
			set_uses(2);
			name = "Slammy"
			desc = "Deal 6 damage to targeted enemy"
			sprite_index = sprIntentAttack		
			return self
		}
	})

	SPELLS.BIG_SLAMMY = register_spell("Hit24", function() {
		with new AttackSpell(24) {
			set_uses(2);
			set_costs(0, 16, 8)
			name = "Slammy Senior"
			desc = "Deal 24 damage to targeted enemy"
			sprite_index = sprIntentAttack
			return self
		}
	})

	SPELLS.BLOCKO = register_spell("Block6", function() {
		with new BlockSpell(6) {
			set_costs(8, 0, 0);
			set_uses(2);
			name = "Blocko"
			desc = "Gain 6 Block"
			sprite_index = sprIntentDefend		
			return self
		}
	})
#endregion