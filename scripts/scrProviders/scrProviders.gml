
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
		return string("{0} - {1}", min_value, max_value)
	}
}

function DamageProvider(innerProvider, _owner, _target) : Provider(provider_get(innerProvider)) constructor {
	if !is_provider(innerProvider) innerProvider = new Provider(innerProvider);
	inner = innerProvider
	owner = _owner
	target = _target
	
	static on_move_decided = function() {
		inner.on_move_decided()
	}
	
	static get = function() {
		var v = inner.get();
		if instance_exists(owner) {
			v += owner.statuses.get_attack_bonus()
		}
		return v;
	}
	
	static toString = function() {
		return string(get())
	}
}
