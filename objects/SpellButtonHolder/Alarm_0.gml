/// @description Create queued Spell Button

if array_length(queue) > 0 {
	var spell = array_shift(queue);
	var height = 4,
		_x = x + sprite_get_xoffset(sprAbilityButton) + (112 * (buttons div height)),
		_y = y + 104 * (buttons mod height);
	with instance_create_layer(_x, _y, layer, SpellButton) {
		self.spell = spell
		position = other.buttons;
		spell.position = position;
	}
	
	buttons++
	if array_length(queue) > 0 {
		alarm[0] = delay;
	}
}