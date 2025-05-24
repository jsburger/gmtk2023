/// @description 

// Inherit the parent event
event_inherited();

// Standard Sprites
spr_hold = sprHandIdleA;
spr_idle = sprHandIdleB;
spr_throw = sprHandThrow;
spr_dash = sprHandDash;

spr_toss = sprHandThanosSnap;

active = function() {
	//Zone where chips cannot be shot to stop people from wasting chips
	//if (abs(die.y - Board.bbox_bottom) >  55) {
		with instance_create_layer(x, y, "Projectiles", obj_chip) {
			motion_set(other.gunangle, 16);
		}
		sound_play_pitch(choose(sndChipThrow1, sndChipThrow2), 1);
		sprite_change(spr_toss);
		
		return true;
	//}
	//return false;
}