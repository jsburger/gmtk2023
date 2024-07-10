/// @ignore
function Tickables_Step() {
	var structs = tickable_register.structs;
	for (var i = 0, l = array_length(structs); i < l; i++) {
		if instance_exists(structs[i].owner) {
			structs[i].struct.tick()
		}
		else {
			array_delete(structs, i, 1);
			i--
			l--
		}
	}
}

function tickable_register(struct, owner) {
	static structs = [];
	array_push(structs, instance_binder(owner, struct))
}

function instance_binder(owner, struct) {
	return {
		owner,
		struct
	}
}