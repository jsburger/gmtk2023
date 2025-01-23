/// @description Create queued Ability Button

if array_length(queue) > 0 {
	var ability = array_shift(queue);
	with instance_create_layer(x + sprite_get_xoffset(sprAbilityButton), y + 104 * buttons, layer, AbilityButton) {
		self.ability = ability
		position = other.buttons;
		ability.position = position;
	}
	
	buttons++
	if array_length(queue) > 0 {
		alarm[0] = delay;
	}
}