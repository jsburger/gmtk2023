function CombatItem(owner) constructor {
	delay = 0;
	target = noone;
	self.owner = owner;
	
	static act = function(runner) {
		
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
		var t = resolve_target(target)
		if instance_exists(t) {
			battler_hurt(t, provider_get(damage), owner)
		}
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
	}
}

/// @ignore
function RecolorItem(count, color, owner = noone) : CombatItem(owner) constructor {
	self.count = count;
	self.color = color;
	sorter = undefined;
	
	static act = function(runner) {
		var n = provider_get(count);
		if n > 0 {
			var c = bricks_recolor(n, provider_get(color), sorter)
			runner.waitTime += (__BRICK_RECOLOR_DELAY * (c - 1)) + 1;
		}
	}
}

function MultiTargetItem(owner, targets, func) : CombatItem() constructor {
	self.targets = targets;
	self.func = func;
	self.owner = owner;
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
	}
}