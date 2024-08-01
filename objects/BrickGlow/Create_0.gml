/// @description 

// Inherit the parent event
event_inherited();

set_hp(1);

super = {
	set_color
}

set_color = function(col) {
	super.set_color(col);
	image_blend = merge_color(image_blend, c_white, .3);
}

on = true;
spr_off = sprBrickGlowOff;
spr_on = sprite_index;

ghost_immune = true;
setup_freeze(sprBrickOverlayFrozen)

disable = function() {
	colorable = false;
	status_immune = true;
	can_take_damage = false;
	
	sprite_index = spr_off;
	on = false;
	snd_impact = sndDieHitMetal;
	
	brick_status_clear(self)
}
enable = function() {
	colorable = true;
	status_immune = false;
	can_take_damage = true;
	
	sprite_index = spr_on;
	on = true;
	snd_impact = sndCoinBig;
}

on_hurt = function(damage) {
	if is_valid_mana(color) {
		var dam = damage;
		if hp < 0 dam += hp;
		mana_give_at(x, y, color, mana_amount * dam);
	}
	if hp <= 0 {
		disable()
		hp = hp_max;
	}
}