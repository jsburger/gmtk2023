
// If the player uses yellow mana for their active or simply has a set amount of uses per turn
global.use_charges = true;
#macro USE_CHARGES global.use_charges

// Prevents dashing, but the safety net launches the ball much higher
global.no_dashes = true;
#macro NO_DASHES global.no_dashes

function tweaks_step() {
	if keyboard_check_pressed(ord("1")) {
		USE_CHARGES = !USE_CHARGES;
	}
	if keyboard_check_pressed(ord("2")) {
		NO_DASHES = !NO_DASHES;
	}
}