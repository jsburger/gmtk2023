/// @description 

encounter = encounter_get();
active = false;
lean = 0;

can_click = function() {
	with EncounterButton if active return false;
	return true;
}
on_click = function() {
	if encounter != undefined {
		global.encounter_current = encounter;
		fade_to(room_test)
		active = true;
	}
}

