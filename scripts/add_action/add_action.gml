/// @context EnemyBattler
/// @returns {Struct.MoveFactory}
function add_action(name, func) {
	//var move = new EnemyMove(self);
	
	//move.name = name
	
	//array_push(actions, move)
	array_push(actions, new MoveFactory(name, func));
	return array_last(actions);
}

#macro MOVESTART with (new EnemyMove(self)) {
#macro MOVEEND return self; }