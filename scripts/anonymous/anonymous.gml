/// Returns a method bound to a dummy struct. Prevents keeping stray objects in memory.
function anonymous(func) {
	static dummy = {};
	return method(dummy, func);
}