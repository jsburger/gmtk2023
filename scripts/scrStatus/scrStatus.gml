function StatusHolder(creator) constructor {
	statuses = [];
	owner = creator;
	
	static add_status = function(status) {
		status.set_owner(owner)
		status.on_add()
		array_push(statuses, status)
		return self
	}
	
	static on_turn_end = function() {
		for (var i = 0; i < array_length(statuses); ++i) {
		    var s = statuses[i];
			var finished = i.on_turn_end();
			if finished {
				array_delete(statuses, i, 1)
				i--
				s.on_remove()
			}
		}
	}
	
	static clear = function(doRemove) {
		if doRemove {
			for (var i = 0; i < array_length(statuses); ++i) {
			    var s = statuses[i];
				s.on_remove()
			}
		}
		array_delete(statuses, 0, array_length(statuses))
	}
	
	static get_attack_bonus = function() {
		return array_reduce(statuses, function(prev, current) {
			return prev + current.get_attack_bonus()
		}, 0)
	}
}

function Status(Duration, Power) constructor {
	duration = Duration;
	strength = Power;
	attack_bonus = 0;
	
	visible = true;
	sprite_index = spr_chip;
	name = "Status"
	desc = "Description"
	
	owner = noone;
	
	static set_owner = function(Owner) {
		owner = Owner
	}
	
	static on_hurt = function() {
		
	}
	
	static get_attack_bonus = function() {
		return attack_bonus;
	}
	
	static on_turn_end = function() {
		duration -= 1;
		if duration <= 0 {
			return true
		}
		return false
	}
	static __on_turn_end_internal = on_turn_end
	
	static on_turn_start = function() {
		
	}
	static __on_turn_start_internal = on_turn_start
	
	static on_add = function() {
		
	}
	static on_remove = function() {
		
	}
}