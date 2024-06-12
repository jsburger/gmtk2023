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