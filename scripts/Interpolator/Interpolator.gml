#macro __Int_auto true

/// @Ingore
function Interpolator(getter, auto = __Int_auto) constructor {
	self.getter = getter;
	var base_value = getter();
	
	display_value = base_value;
	real_value = base_value;
	
	if auto tickable_register(self);
	
	static tick = function() {
		real_value = getter();
		real_value ??= 0; //Replace undefined with 0
		if display_value != real_value {
			interp()
		}
	}
	
	static interp = function() {
		var dif = display_value - real_value,
			clmp = abs(dif) > 10 ? .5 : .25;
		display_value -= clamp(dif, -clmp, clmp)
	}
	
	static get = function() {
		return display_value;
	}
	
	static set = function(i) {
		display_value = i;
		real_value = i;
	}
	
}

function instance_ref(inst, variable) {
	with {
		inst,
		variable
	} return function() {
		if argument_count <= 0 {
			return variable_instance_get(inst, variable)
		}
		else variable_instance_set(inst, variable, argument0)
	}
}

/// Used for Health Bars and Mana Displays
function MeterInterpolator(getter, auto = __Int_auto) : Interpolator(getter, auto) constructor {
	
	static interp = function() {
		var dif = display_value - real_value,
			clmp = abs(dif) > 10 ? .5 : .25;
		display_value -= clamp(dif, -clmp, clmp)
	}
}

function ColorInterpolator(getter, rate = .05) : Interpolator(getter, true) constructor {
	self.rate = rate;
	
	static interp = function() {
		display_value = merge_color(display_value, real_value, rate)
	}
}