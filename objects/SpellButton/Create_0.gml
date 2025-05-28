/// @description 
setup = function() {
	if is_string(spell) && string_length(spell) > 0 {
		spell = spell_get(spell_key);
	}
}

spell = undefined;
setup()
active = false;
lean = 0;
position = 0;
playSound = true;

image_xscale = .325;

hovered = false;

can_click = function() {
	return combat_active();
}
on_click = function() {
	if spell != undefined {
		var denied = true;
		if spell.can_cast() {
			// Try to mount spell and see if it succeeds
			if CombatRunner.spell_mount(spell) {
				denied = false;
				if !spell.is_instant {
					active = true;	
				}
				else {
					lean = 1.5
				}
			}
		}
		if denied {
			lean = -.3
		}
	}
}

