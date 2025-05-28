/// @description 

// Inherit the parent event
event_inherited();

extra_objects = [BrickTrash, FakeSolid]
spr_icon = sprOneArmedBanditIcon;

set_hp(80);
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
			mount_move(payout);
		Timeline.update();
		exit;
	}
	super.decide_actions();
	//mount_move(payout);
	Timeline.update();
}

//base_odds = 15;
//odds = base_odds;
procs = 0;
sleeping = false;

garbage_brick_count = 5;
red_count = 10;

blue_wave_count = 0;
red_wave_count = 0;


on_turn_end = function() {
	sleeping = !sleeping;
	//odds = base_odds;
	procs = 0;
}

nap = new MoveFactory("NAPPING", function() {
	MOVESTART
	wait(15);
	add_intent(new Intent(sprIntentMisc, "Zzz"))
		.with_desc("Pass the turn.");
			
	MOVEEND
})

add_action("RESPIN", function() {
	MOVESTART
	intent_auto = false;
	block(4);
	run(function() {
		blue_wave_count += 1;
	}).delay = 0;
	
	var blue_payout = new DummyStatus("Blue Payout",
		"PAYOUT will create an additional line of blue bricks.",
		new ColoredSprite(COLORS.BLUE, sprBrick)
	);
	apply_status(TARGETS.SELF, blue_payout)
	
	add_intent(new Intent(new ColoredSprite(COLORS.BLUE, sprBrick), "4"))
		.with_desc("Gain 4 block.\nPAYOUT will create an additional line of blue bricks.")
		.with_backdrop(sprIntentDefend);
		//.height /= 2;
	MOVEEND
})

add_action("HOT STUFF", function() {
	MOVESTART
	intent_auto = false;
	var damage = as_damage(3);
	hit(damage);
	run(function() {
		red_wave_count += 1;
	}).delay = 0;
	
	var red_payout = new DummyStatus("Red Payout",
		"PAYOUT will create an additional line of red bricks.",
		new ColoredSprite(COLORS.RED, sprBrick)
	);
	apply_status(TARGETS.SELF, red_payout)
	
	add_intent(new Intent(new ColoredSprite(COLORS.RED, sprBrick), damage))
		.with_desc(format("Deal {0} damage.\nPAYOUT will create an additional line of red bricks.", damage))
		.with_backdrop(sprIntentAttack)
		//.height /= 2;
	MOVEEND
})

add_action("JACKPOT", function() {
	MOVESTART
	add_intent(new Intent(sprBrickSquare, "+2"))
		.with_desc("PAYOUT will create 2 additional trash bricks.");
	wait(15)
	run(function() {
		garbage_brick_count += 2;
		//odds *= 2;
		//procs += 1;
	})
	
	var payout = new DummyStatus("Jackpot",
		"PAYOUT will create 2 additional trash bricks.",
		new Sprite(sprBrickSquare).with_color(c_gray)
	);
	apply_status(TARGETS.SELF, payout)
	
	MOVEEND	
})

#region Payout
	/*
	var get_jackpot_damage = function() {
		if chance_bad(odds, 100) return instance_number(BrickTrash);
		return 0;
	}

	var get_question_marks = function() {
		if procs == 0 return "?";
		return string_repeat(".", procs) + "?";
	}
	*/
	spawn_waves = function(item, runner) {
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
			with statuses.find("Blue Payout") knock();
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
				//a[i].set_burning(true);
			}
		
			red_wave_count -= 1;
			with statuses.find("Red Payout") knock();
			runner.wait(15)
			exit;
		}
		item.done();
	}
	
	payout = new MoveFactory("PAYOUT", function() {
		MOVESTART
		is_rerollable = false;
	
		// Deal damage
		//var damage = as_damage(get_jackpot_damage);

		var damage = as_damage(function() {
			return (instance_number(BrickTrash) * 3);
		})
		hit(damage)
		var sprite = new Sprite(sprBrickSquare);
			sprite.image_blend = c_gray;
		add_intent(new Intent(sprIntentAttack, damage))
			.with_backdrop(sprite)
			.with_desc("Deal 3 damage for every Trash Brick")
	
	
		// Spawn trash bricks.
		run(function() {
			var count = garbage_brick_count,
				tries = 0;
			while count > 0 {
				tries += 1;
				if tries > 100 exit;
				var inst = place_trash_bricks(board_column_random(), BrickTrash, 1);
				if instance_exists(inst){ 
					count -= 1;
					garbage_brick_count -= 1;
					//inst.set_color(COLORS.YELLOW)
				}
			}
			with statuses.find("Jackpot") clear();
		})
		
		add_intent(new Intent(sprBrickSquare, 5))
			.with_desc("Spawn 5 Trash Bricks")
		
		wait(15)
	
		// Spawn red and blue bricks
		raw(other.spawn_waves)
		MOVEEND
	
	})
#endregion