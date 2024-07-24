global.default_vars = [
	"hspeed",
	"vspeed",
	"image_speed",
	"gravity",
	"friction",
	"canz"
]

function vars_apply(vars) {
	var names = variable_struct_get_names(vars),
		l = array_length(names);
	for (var i = 0; i < l; ++i) {
		variable_instance_set(self, names[i], variable_struct_get(vars, names[i]))
	}
}

/// Goes through all variable names, sets the instance's to 0, and saves the old value to a struct.
function vars_steal(names) {
	var obj = {};
	for (var i = 0, l = array_length(names); i < l; i++) {
		variable_struct_set(obj, names[i], variable_instance_get(self, names[i]))
		variable_instance_set(self, names[i], 0)
	}
	return obj;
}

/// Returns a function that gets a variable or sets a variable if an input is given
function instance_ref(inst, variable) {
	with {
		inst,
		variable : variable_get_hash(variable)
	} return function() {
		if argument_count <= 0 {
			return struct_get_from_hash(inst, variable)
		}
		else struct_set_from_hash(inst, variable, argument0)
	}
}
