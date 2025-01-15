function Formatter() constructor {
	var _stringIn = argument[0];
	var _args = []
	for (var i = 1; i < argument_count; i++) {
		array_push(_args, argument[i])
	}
	
	text = _stringIn;
	values = _args;
	
	static get_text = function() {
		var result = text;
		for (var i = 0; i < array_length(values); i++) {
			result = string_replace_all(result, "{" + string(i) + "}", string(provider_get(values[i])))
		}
		return result
	}
	
	static toString = function() {
		return get_text()
	}
}

/// @desc Returns a formatted string if all arguments are static, or a Formatter if any are dynamic.
function format() {
	var args = [argument[0]],
		dynamic = false;
	for (var i = 1; i < argument_count; i++) {
		array_push(args, argument[i]);
		if !dynamic && (is_provider(argument[i]) || is_method(argument[i])) {
			dynamic = true;
		}
	}
	if dynamic {
		// If you use script_execute on a constructor, it turns the current scope into that class.
		// So, new empty struct I guess.
		with ({}) {
			script_execute_ext(Formatter, args)
			return self;
		}
	}
	return script_execute_ext(string, args);
}