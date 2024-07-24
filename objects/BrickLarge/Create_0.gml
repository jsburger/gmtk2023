/// @description 

// Inherit the parent event
event_inherited();

spr_damaged = sprBrickLargeBroken
on_hurt = function(damage) {
	sprite_index = spr_damaged
}

mana_amount = 2;
setup_freeze(sprBrickLargeOverlayFrozen)