/// @description 
setup = function() {
	var prototype = ability_get_prototype(ability_key)
	if prototype != undefined {
		ability = prototype()
	}
}

ability = undefined;
setup()
active = false;
lean = 0;

can_click = function() {
	return combat_active();
}
on_click = function() {
	if ability != undefined {
		if ability.can_cast() {
			with CombatRunner mount_ability(other.ability)
			active = true;
		}
		else {
			lean = -.3
		}
	}
}

