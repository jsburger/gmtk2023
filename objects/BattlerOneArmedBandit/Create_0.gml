/// @description 

// Inherit the parent event
event_inherited();

extra_objects = [BrickTrash, FakeSolid]

move_max = 3;
movemode = moveOrder.RANDOM;
//move_rerolls = 3;

super = {
	decide_actions
}
decide_actions = function() {
	if sleeping {
		clear_actions();
			//This part is optional. Doing nothing just works.
			var move = nap.clone();
			array_push(current_actions, move);
			move.on_move_decided();
		Timeline.update();
		exit;
	}
	super.decide_actions();
	var move = payout.clone()
	move.on_move_decided()
	array_push(current_actions, move)
	Timeline.update();
}

base_odds = 15;
odds = base_odds;
procs = 0;
sleeping = false;

garbage_brick_count = 5;
red_count = 10;

blue_wave_count = 0;
red_wave_count = 0;


on_turn_end = function() {
	sleeping = !sleeping;
	odds = base_odds;
	procs = 0;
	blue_wave_count = 0;
	red_wave_count = 0;
}

nap = new EnemyMove();
with nap {
	name = "NAPPING";
	desc = "Zzz..."
	set_owner(other);
	wait(15)
	set_intent(INTENT.MISC)
}

with add_action("RESPIN") {
	desc = "Grant 4 Shield.\nPAYOUT will create an additional line of blue bricks."
	block(4);
	set_intent(INTENT.BLOCK, 4)
	run(function() {
		blue_wave_count += 1;
	}).delay = 0;
}

with add_action("HOT STUFF") {
	desc = "Deal 2 Damage.\nPAYOUT will create an additional line of burning red bricks."
	var damage = as_damage(2);
	hit(damage);
	set_intent(INTENT.ATTACK, damage)
	run(function() {
		red_wave_count += 1;
	}).delay = 0;
}

with add_action("JACKPOT") {
	desc = "Double the odds of PAYOUT dealing damage."
	set_intent(INTENT.MISC)
	wait(15)
	run(function() {
		odds *= 2;
		procs += 1;
	})
	
}

#region Payout
	var get_jackpot_damage = function() {
		if chance_bad(odds, 100) return instance_number(BrickTrash);
		return 0;
	}

	var get_question_marks = function() {
		if procs == 0 return "?";
		return string_repeat(".", procs) + "?";
	}

	var spawn_waves = function(item, runner) {
		if blue_wave_count > 0 {
			var m = board_column_max(),
				b = [];
			for (var i = 0; i < m; i++) {
				with place_trash_bricks(i, BrickNormal, 1) {
					array_push(b, self);
					//set_color(COLORS.BLUE)
				}
			}
			array_shuffle_ext(b);
			
			for (var i = 0; i < min(red_count, array_length(b)); i++) {
				b[i].set_color(COLORS.BLUE)
			}
			
			blue_wave_count -= 1;
			runner.wait(15)
			exit;
		}
		if red_wave_count > 0 {
			var m = board_column_max(),
				a = [];
			for (var i = 0; i < m; i++) {
				with place_trash_bricks(i, BrickNormal, 1) {
					array_push(a, self);
					//set_burning(true);
				}
			}
			array_shuffle_ext(a);
			
			for (var i = 0; i < min(red_count, array_length(a)); i++) {
				a[i].set_color(COLORS.RED)
			}
		
			red_wave_count -= 1;
			runner.wait(15)
			exit;
		}
		item.done();
	}
	payout = new EnemyMove();
	
	with payout {
		set_owner(other);
		name = "PAYOUT"
		desc = string(
			"Deal damage equal to # of Garbage Bricks, {0}% chance of hitting.\nCreate {1} Garbage Bricks.",
			other.base_odds, other.garbage_brick_count);
		is_rerollable = false;
	
		// Spawn 5 trash bricks.
		run(function() {
			var count = garbage_brick_count,
				tries = 0;
			while count > 0 {
				tries += 1;
				if tries > 100 exit;
				var inst = place_trash_bricks(board_column_random(), BrickTrash, 1);
				if instance_exists(inst){ 
					count -= 1;
					inst.set_color(COLORS.YELLOW)
				}
			}
		})
		wait(15)
	
		// Deal damage
		var damage = as_damage(get_jackpot_damage);
		var damage_preview = as_damage(function() {
			 return instance_number(BrickTrash) + garbage_brick_count;
		})
		hit(damage)
		set_intent(INTENT.ATTACK,
			new Formatter("{0}{1}", damage_preview, new FunctionProvider(get_question_marks)))
	
		// Spawn red and blue bricks
		raw(spawn_waves)
	
	}
#endregion


/*
var setup_trash = function(move) {
	move.run(function() {
		var m = board_column_max();
		for (var i = 0; i < m; i++)
			place_trash_bricks(i, BrickTrash, 1)
	})
	move.wait(10)
};

with add_action("BAR") {
	desc = "Suck them bones dry, kid"
	setup_trash(self)
	var damage = as_damage(0);
	hit(damage)
	set_intent(INTENT.ATTACK, damage);
	
	wait(10)
}

with add_action("JACKPOT!") {
	var damage = as_damage(new FunctionProvider(jackpot_damage));
	hit(damage);
	set_intent(INTENT.ATTACK, "??")
	desc = "25% chance to deal 20 damage.\nDouble this chance for any upcoming JACKPOTS."
	
	run(increase_odds)
	wait(10)
}

with add_action("RESPIN") {
	var b = 8;
	block(b);
	set_intent(INTENT.BLOCK, b)
	desc = string("Gain {0} block", b);
	wait(10)
}