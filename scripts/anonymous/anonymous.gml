/// Returns a method bound to noone. Prevents keeping stray objects in memory.
function anonymous(func){
	return method(noone, func);
}