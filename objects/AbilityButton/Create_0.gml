/// @description 
setup = function() {
	if is_string(ability) && string_length(ability) > 0 {
		ability = ability_get(ability_key);
	}
}

ability = undefined;
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
	if ability != undefined {
		var denied = true;
		if ability.can_cast() {
			// Try to mount ability and see if it succeeds
			if CombatRunner.mount_ability(ability) {
				denied = false;
				if ability.needs_target{
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

