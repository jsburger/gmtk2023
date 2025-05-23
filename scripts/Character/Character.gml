function Character(_name) constructor {
	name = _name;
	spr_idle = sprCuffsIdle;
	spr_fire = sprCuffsFire;
	
	shooter = Shooter;
	
	bg_color = c_red;
	
	ball = PlayerBall;
	
	static set_sprites = function(idle, fire) {
		spr_idle = idle;
		spr_fire = fire;
	}
	
}

on_game_load(function() {
	change_character(CHARACTERS.CUFFS);
})

global.characters = {}
#macro CHARACTERS global.characters

CHARACTERS.CUFFS = new CuffsCharacter();

CHARACTERS.JUNO = new JunoCharacter();

/// @param {Struct.Character} character
function change_character(character) {
	if (Player.character == character) exit;
	Player.character = character;
	with PlayerBattler {
		sprite_change(character.spr_idle)
		bg_color = character.bg_color;
	}
	with Shooter {
		instance_create_layer(x, y, layer, character.shooter, {can_shoot, has_dice, die})
		instance_destroy()
	}
}

/// @param {Asset.GMSprite} sprite
function player_animate(sprite) {
	with PlayerBattler {
		sprite_change(sprite);
	}
}

/// Plays firing animation for player
function player_fire() {
	player_animate(Player.character.spr_fire)
}

