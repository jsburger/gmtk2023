function CallStack() constructor {
	funcs = [];
	static add_layer = function(func) {
		array_push(funcs, func)
	}
	
	static call = function() {
		if argument_count > 0 {
			arguments_pack
			for (var i = 0; i < array_length(funcs); i++) {
				method_call(funcs[i], args);
			}
		}
		else {
			for (var i = 0; i < array_length(funcs); i++) {
				funcs[i]();
			}
		}
	}
	
	static as_function = function() {
		return method(self, call);
	}
}