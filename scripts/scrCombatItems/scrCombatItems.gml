function CombatItem(owner) constructor {
	delay = 0;
	target = noone;
	self.owner = owner;
	progress = 0;
	finished = false;
	
	static done = function() {
		finished = true;
	}
	
	static act = function(runner) {
		done();
	}
	
	static get_target = function() {
		if target != noone return resolve_target(target);
		return noone;
	}
	
}

///@param target
///@param {Struct, Real} damage
function AttackItem(target, damage, owner = noone) : CombatItem(owner) constructor {
	delay = 15
	self.damage = damage;
	self.target = target;
	
	static act = function(runner) {
		var d = provider_get(damage);
		if d > 0 {
			var t = resolve_target(target)
			if instance_exists(t) {
				battler_hurt(t, d, owner)
			}
		}
		else {
			delay = 0;
		}
		done();
	}
}

function DefendItem(target, Block, owner = noone) : CombatItem(owner) constructor {
	delay = 15
	self.block = Block
	self.target = target
	
	static act = function(runner) {
		var t = resolve_target(target)
		if instance_exists(t) {
			battler_give_block(t, provider_get(self.block))
		}
		done();
	}
}

function WaitItem(duration, owner = noone) : CombatItem(owner) constructor {
	delay = duration;
}

function StatusItem(_target, _statusType, _strength, owner = noone) : CombatItem(owner) constructor {
	delay = 15
	status = _statusType
	strength = _strength
	target = _target;
	
	static act = function(runner) {
		var t = resolve_target(target)
		if instance_exists(t) {
			t.statuses.add_status(status, provider_get(strength))
		}
		done();
	}	
}

/// @param {Struct, Id.Instance} owner
/// @param {Function} func
/// @param {Any} arguements...
function FunctionItem() : CombatItem(argument[0]) constructor {
	self.func = argument[1];
	args = undefined;
	if argument_count > 2 args = [];
	for (var i = 2; i < argument_count; i++) {
		array_push(args, argument[i])
	}
	delay = 0;
	
	static act = function(runner) {
		if args != undefined {
			method_call(func, args)
		}
		else func()
		done();
	}
}

/// @ignore
function RecolorItem(count, color, owner = noone) : CombatItem(owner) constructor {
	self.count = count;
	self.color = color;
	sorter = undefined;
	
	results = undefined;
	
	static act = function(runner) {
		static finder = new InstanceFinder(parBoardObject) 
			.filter(function(inst, col) {return inst.colorable && inst.color != col})
			.prefer(function(inst) {return inst.color == COLORS.NONE});
		if (progress == 0) {
			var n = provider_get(count);
			if n <= 0 {
				done();
				exit;
			}
			finder.push(sorter, color);
			results = finder.get(n);
		}
		var length = array_length(results);
		if (results != undefined && progress < length) {
			var col = provider_get(color)
			var brick = results[progress];
			brick_recolor(brick, col)
			if (progress != (length - 1)) runner.wait(__BRICK_RECOLOR_DELAY)
		}
		if progress >= length done();
	}
}

function MultiTargetItem(owner, targets, func) : CombatItem(owner) constructor {
	self.targets = targets;
	self.func = func;
	delay = 0;
	
	static act = function(runner) {
		var t = resolve_multitarget(targets);
		if !is_array(t) exit;
		var interface = new EnemyMoveMultiTarget(owner),
			call = method(interface, func);
		for (var i = 0; i < array_length(t); i++) {
			if instance_exists(t[i]) {
				call(t[i])
			}
		}
		done();
	}
}

/// A CombatItem which doesn't declare itself done and passes itself to the function
function RawCombatItem(owner, _func) : CombatItem(owner) constructor {
	func = _func;
	delay = 0;
	
	static act = function(runner) {
		func(self, runner)
	}
	
}

global.dead_bricks = [];
function RespawnItem(owner, count) : CombatItem(owner) constructor {
	self.count = count;
	
	static act = function(runner) {
		var d = global.dead_bricks;
		var n = provider_get(count);
		if (progress >= n || array_length(d) <= 0) {
			done();
			exit;
		}
		var index = irandom(array_length(d) - 1);
		with spawn_json_object(d[index]) {
			if instance_is(self, parBoardObject) {
				alarm[0] = 1;
			}
		}
		array_delete(d, index, 1);
		if (n != progress - 1) runner.wait(4);
	}
}