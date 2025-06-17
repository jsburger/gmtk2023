global.run = new Run();
global.run_mode = false;

function Run() constructor {
	#region Build Encounter Deck
		var deck_count = 3;
		decks = [];
		var encounter_count = array_length(global.encounters);
		
		var i = 0;
		repeat(deck_count) {
			array_push(decks, []);
		}
		var shuffled = array_shuffle(global.encounters);
		repeat(encounter_count) {
			array_push(decks[(i++ mod deck_count)], array_pop(shuffled));
		}
		
	#endregion
	
	victories = 0;
	
	static on_deck_clicked = function(deck) {
		var encounter = array_shift(decks[deck]);
		encounter_set(encounter);
		fade_to(room_test);
	}
	
	static prepare_encounters = function() {
		with RunModeEncounterButton {
			encounter = array_first(other.decks[deck]);
		}
	}
	
	static on_combat_ended = function() {
		victories += 1;
	}
	
}