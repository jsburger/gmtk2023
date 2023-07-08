function add_reset_callback(func) {
	static resetCalls = [];
	
	array_push(resetCalls, func)
}

function game_reset(){

	array_foreach(add_reset_callback.resetCalls, function(call) {
		call()
	})
	
	game_restart()
}