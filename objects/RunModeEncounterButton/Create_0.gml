/// @description 
on_click = function() {
	if encounter != undefined {
		global.run.on_deck_clicked(deck);
	}
}

can_click = function() {
	return !instance_exists(FadeTo);
}