/// Returns a method bound to undefined. Prevents keeping stray objects in memory.
function anonymous(func) {
	return method(undefined, func);
}