/// @param {String} name
/// @param {Function} spellFactory
function register_item(name, itemFactory) {
	static items = ds_map_create();
	ds_map_add(items, name, itemFactory)
	return name;
}

/// @param {String} name
/// @returns {Struct.Spell, Undefined}
function item_get(name) {
	var proto = register_item.items[? name];
	if proto == undefined return undefined;
	// Feather disable once GM1045
	return proto();
}

/// @param {Struct.Item,String} name
/// Give the player an item
function item_grant(name) {
	var item = name;
	if is_string(name) {
		item = item_get(name);
	}
	array_push(global.items, item);
	return item;
}


global.itemKeys = {};
#macro ITEMS global.itemKeys


