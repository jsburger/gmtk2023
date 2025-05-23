#macro HOOK_BODY \
	static hooks = [];\
	if argument_count > 0 { \
		array_push(hooks, argument[0]); \
	} \
	else { \
		for (var i = 0; i < array_length(hooks); i++) { \
			hooks[i](); \
		} \
	}

function on_board_clear(){
	HOOK_BODY
}