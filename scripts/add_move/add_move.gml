/// @context EnemyBattler
/// @returns {Struct.EnemyMove}
function add_action(name) {
	var move = new EnemyMove();
	move.set_owner(self)
	move.name = name
	move.desc = "Description"
	
	array_push(actions, move)
	return move
}
