function Serializer(_owner) constructor {
	//writers = [];
	//readers = [];
	layers = {};
	owner = _owner;
	
	/// Add a layer to the serializer. Saves as "name" : (to_struct's output)
	static add_layer = function(name, to_struct, from_struct = undefined) {
		from_struct ??= method(owner, default_reader)
		struct_set(layers, name, {to_struct, from_struct});
		//array_push(writers, to_struct)
		//array_push(readers, from_struct)
	}
	
	/// Add a layer for a specific variable. Saves value directly.
	static add_var_layer = function(instance, name, setter = undefined) {
		var ref = instance_ref(instance, name);
		setter ??= ref
		add_layer(name, ref, setter);
	}
	
	static remove_layer = function(name) {
		struct_remove(layers, name)
	}
	
	static write = function() {
		var ret = {};
		for (var names = struct_get_names(layers), i = 0; i < array_length(names); i++) {
			var value = struct_get(layers, names[i]).to_struct();
			if value != undefined {
				struct_set(ret, names[i], value)
			}
		}
		return ret;
		//return array_map(writers, function(i) {return i()})
	}
	static read = function(data) {
		for (var names = struct_get_names(data), i = 0; i < array_length(names); i++) {
			var value = struct_get(data, names[i]),
				reader = struct_get(layers, names[i]);
			if value != undefined {
				reader.from_struct(value)
			}
		}
		//array_foreach(data, function(element, index) {
		//	readers[index](element)
		//})
	}
	
	/// @ignore
	static default_reader = function(struct) {
		vars_apply(struct)
	}
}