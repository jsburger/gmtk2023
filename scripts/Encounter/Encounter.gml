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

// Make all new boards required
schedule(3, function() {
	for (var i = 0; i < array_length(global.encounters); i++) {
		for (var o = 0; o < array_length(global.encounters[i].boards); o++) {
			level_id_by_name(global.encounters[i].boards[o])
		}
	}
})

function encounter_add(encounter) {
	array_push(global.encounters, encounter)
}

function encounter_get() {
	return array_random(global.encounters)
}

encounter_add(
	new Encounter("One Squirrel")
		.with_boards("TestColumns1")
		.with_enemies(BattlerGayLittleSquirrel)
)


encounter_add(
	new Encounter("Two Squirrels")
		.with_boards("TestPawn1", "TestPawn2")
		.with_enemies(BattlerGayLittleSquirrel,  BattlerGayLittleSquirrel)
)


encounter_add(
	new Encounter("Three Squirrels")
		.with_boards("TestPawn3")
		.with_enemies(BattlerGayLittleSquirrel,  BattlerGayLittleSquirrel, BattlerGayLittleSquirrel)
)

encounter_add(
	new Encounter("The Slasher...")
		.with_boards("TestSlasher1", "TestSlasher2", "TestSlasher3", "TestSlasher4", "TestSlasher5")
		.with_enemies(BattlerSlasher)
)

encounter_add(
	new Encounter("Casino World")
		.with_boards("Symbols3a", "Symbols3b")
		.with_enemies(
			[BattlerSymbol, {form: MANA.RED}],
			[BattlerSymbol, {form: MANA.BLUE}],
			[BattlerSymbol, {form: MANA.YELLOW}]
		)
)

encounter_add(
	new Encounter("Two Symbols")
		.with_boards("Symbols2a", "Symbols2b")
		.with_enemies(
			[BattlerSymbol, {form: MANA.YELLOW}],
			[BattlerSymbol, {form: MANA.BLUE}]
		)
)

encounter_add(
	new Encounter("One Tomato")
		.with_boards("TestCastle1")
		.with_enemies(BattlerTomato)		
)

encounter_add(
	new Encounter("The Whale (2022)")
		.with_boards("Whale1a", "Whale2a")
		.with_enemies(BattlerWhale)
)

//encounter_add(
//	new Encounter("STS Sentries")
//		.with_boards("Sentry1a")
//		.with_enemies(BattlerSentry, BattlerSentry)	
//)

encounter_add(
	new Encounter("Two Dolphins")
		.with_boards("TestDolphin2a")
		.with_enemies(BattlerDolphin, BattlerDolphin)	
)

encounter_add(
	new Encounter("Singer")
		.with_boards("TestDuality1", "TestDuality2")
		.with_enemies(BattlerSinger)
)

encounter_add(
	new Encounter("One Singer, One Tomato")
		.with_boards("TestCover1")
		.with_enemies(BattlerSinger, BattlerTomato)
)

encounter_add(
	new Encounter("Scary Monster...")
		.with_boards("TestDemon1")
		.with_enemies(BattlerDemon)
)

encounter_add(
	new Encounter("The One Armed Bandit")
		.with_boards("TestBandit1", "TestBandit2")
		.with_enemies(BattlerOneArmedBandit)
)

//encounter_add(
//	new Encounter("Dolphin, Sentry")
//		.with_boards("TestDuos1")
//		.with_enemies(BattlerDolphin, BattlerSentry)	
//)

encounter_add(
	new Encounter("High Rollers")
		.with_boards("TestBumperTown1")
		.with_enemies(BattlerHighRoller, BattlerHighRoller, BattlerHighRoller, BattlerHighRoller)	
)

encounter_add(
	new Encounter("Smoker")
		.with_boards("TestShelves1")
		.with_enemies(BattlerSmoker)	
)

encounter_add(
	new Encounter("Smoker, High Rollers")
		.with_boards("TestHybrid1")
		.with_enemies(BattlerSmoker, BattlerHighRoller, BattlerHighRoller)	
)

encounter_add(
	new Encounter("Smoker, Dolphin")
		.with_boards("TestPyramid1")
		.with_enemies(BattlerSmoker, BattlerDolphin)	
)

encounter_add(
	new Encounter("Old People, Bar Fly")
		.with_boards("TestSandwich1")
		.with_enemies(BattlerBarFly, BattlerOldPerson, BattlerOldPerson)	
)

encounter_add(
	new Encounter("Old People")
		.with_boards("TestSlots1", "TestSlots2")
		.with_enemies(BattlerOldPerson, BattlerOldPerson)	
)

encounter_add(
	new Encounter("Two Germs")
		.with_boards("TestGerms1")
		.with_enemies(BattlerGerm, BattlerGerm)
)

encounter_add(
	new Encounter("Super Germ")
		.with_boards("TestAbstract1")
		.with_enemies(BattlerSuperGerm)
)

encounter_add(
	new Encounter("Cultist")
		.with_boards("TestCultist1", "TestCultist2")
		.with_enemies(BattlerCultist)
)


//global.encounters = [];
//encounter_add(new Encounter("Collision Test").with_boards("CollisionTester"))