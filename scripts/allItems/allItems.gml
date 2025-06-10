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

on_game_load(function() {
	item_grant(ITEMS.RED_PAINT)
})

ITEMS.RED_PAINT = register_item("RedManaToRedBrick", function() {
	with new Item() {
		name = "Red Paint";
		desc = "For each Red Mana you gain,\n1 in 3 to color a brick Red.";
		sprite_index = sprItemRedPaint;
		
		on_mana_gained = function(type, amount) {
			if type == MANA.RED {
				var count = 0;
				repeat(amount) {
					if chance_good(1, 3) {
						amount += 1;
					}
				}
				if amount > 0 {
					global.interface.recolor(amount, COLORS.RED);
				}
			}
		}
		
		return self;
	}
})
