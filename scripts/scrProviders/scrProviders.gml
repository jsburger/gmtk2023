
function Provider(_value) constructor {
	
	value = _value
	
	static get = function() {
		return value;
	}
	
	static on_move_decided = function() {}
	
	static toString = function() {
		return string(value);
	}
}

function RangeProvider(minValue, maxValue) : Provider(minValue) constructor {
	min_value = minValue
	max_value = maxValue
	
	static on_move_decided = function() {
		value = irandom_range(min_value, max_value)
	}
	
	static toString = function() {
		return string(value)
		//return string("{0} - {1}", min_value, max_value)
	}
}

function DamageProvider(innerProvider, _owner, _target) : Provider(provider_get(innerProvider)) constructor {
	inner = innerProvider
	owner = _owner
	target = _target
	
	static on_move_decided = function() {
		if is_provider(inner) {
			inner.on_move_decided()
		}
	}
	
	static get = function() {
		var v = provider_get(inner)
		if instance_exists(owner) {
			v += owner.statuses.get_attack_bonus()
		}
		return v;
	}
	
	static toString = function() {
		return string(get())
	}
}

/// @param {Function} func
function FunctionProvider(func) : Provider(0) constructor {
	getter = func;
	value = func()
	static get = function() {
		return getter();
	}
}

function ColorNameProvider(color) : Provider(0) constructor {
	self.color = color;
	static get = function() {
		return color_get_name(provider_get(color));
	}
}
