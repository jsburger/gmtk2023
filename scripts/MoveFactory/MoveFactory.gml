function MoveFactory(name, getter) constructor {
	self.name = name;
	self.func = getter;

	static get = function() {
		var move = func();
		move.name = name;
		return move;
	}
}