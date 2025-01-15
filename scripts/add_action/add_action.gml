/// @context EnemyBattler
/// @returns {Struct.EnemyMove}
function add_action(name) {
	var move = new EnemyMove(self);
	
	move.name = name
	move.desc = "Description"
	
	array_push(actions, move)
	return move
}
