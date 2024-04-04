/// @context EnemyBattler
/// @returns {Struct.EnemyMove}
function add_action(name, desc) {
	var move = new EnemyMove();
	move.set_owner(self)
	move.name = name
	move.desc = desc
	
	array_push(actions, move)
	return move
}
