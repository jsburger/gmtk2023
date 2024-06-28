/// @ignore
function Tickables_Step() {
	static structs = [];
	for (var i = 0, l = array_length(structs); i < l; i++) {
		if weak_ref_alive(structs[i]) {
			structs[i].ref.tick()
		}
		else {
			array_delete(structs, i, 1);
			i--
			l--
		}
	}
}

function tickable_register(struct) {
	array_push(Tickables_Step.structs, weak_ref_create(struct))
}