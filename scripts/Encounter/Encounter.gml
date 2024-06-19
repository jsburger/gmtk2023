function Encounter(_name) constructor {

	name = _name;
	enemies = [];
	boards = [];
	
	static with_enemies = function() {
		for (var i = 0; i < argument_count; i++) {
			array_push(enemies, argument[i])
		}
		return self;
	}
	
	static with_boards = function() {
		for (var i = 0; i < argument_count; i++) {
			array_push(boards, argument[i])
		}
		return self;
	}
	
	static get_board = function() {
		return array_random(boards);
	}
}

global.encounters = [];
global.encounter_current = undefined;

function encounter_add(encounter) {
	array_push(global.encounters, encounter)
}

function encounter_get() {
	return array_random(global.encounters)
}

encounter_add(
	new Encounter("One Squirrel")
		.with_boards("Full Clear Test")
		.with_enemies(BattlerGayLittleSquirrel)
)


encounter_add(
	new Encounter("Two Squirrels")
		.with_boards("Deconstructed Cheeseburger", "Double Silo")
		.with_enemies(BattlerGayLittleSquirrel,  BattlerGayLittleSquirrel)
)


encounter_add(
	new Encounter("Three Squirrels")
		.with_boards("Deconstructed Cheeseburger", "Double Silo")
		.with_enemies(BattlerGayLittleSquirrel,  BattlerGayLittleSquirrel, BattlerGayLittleSquirrel)
)

encounter_add(
	new Encounter("The Slasher...")
		.with_boards("Deconstructed Cheeseburger", "Double Silo")
		.with_enemies(BattlerSlasher)
)
