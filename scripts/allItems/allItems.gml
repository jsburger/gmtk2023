/// @param {String} name
/// @param {Function} spellFactory
function register_item(name, itemFactory) {
	static registered_items = ds_map_create();
	ds_map_add(registered_items, name, itemFactory)
	return name;
}

/// @param {String} name
/// @returns {Struct.Item, Undefined}
function item_get(name) {
	var proto = register_item.registered_items[? name];
	if proto == undefined return undefined;
	// Feather disable once GM1045
	return proto() ?? Item.last_item;
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

function item_random() {
	return array_random(ds_map_keys_to_array(register_item.registered_items));
}


global.itemKeys = {};
#macro ITEMS global.itemKeys

//on_game_load(function() {
//	item_grant(ITEMS.RED_PAINT)
//})

ITEMS.RED_PAINT = register_item("RedManaToRedBrick", function() {
	with new Item() {
		name = "Red Paint";
		odds = 2;
		desc = $"For each Red Mana you gain,\n1 in {odds} to color ANY brick Red.";
		sprite_index = sprItemRedPaint;
				
		on_mana_gained = function(type, amount) {
			static finder = new InstanceFinder(parBrick).filter(colorable_filter(COLORS.RED));
			if type == MANA.RED {
				var count = 0;
				repeat(amount) {
					if chance_good(1, odds) {
						count += 1;
					}
				}
				if count > 0 {
					interface.recolor(count, COLORS.RED).finder = finder;
				}
			}
		}
		
		return self;
	}
})

ITEMS.PURPLE_TURN_START = register_item("PurpleBricksOnTurnStart", function() {
	with new Item() {
		name = "Scary Aura";
		count = 4;
		desc = $"At the start of your turn,\nColor {count} bricks Purple.";
		
		sprite_index = sprItemPurpleAura;
		
		on_turn_start = function() {
			interface.recolor(count, COLORS.PURPLE);
		}
		
		return self;
	}
});

ITEMS.BLOCK_TURN_START = register_item("BlockTurnStart", function() {
	with new Item() {
		name = "Friendly Shield";
		block = 4;
		desc = $"At the start of your turn,\ngain {block} Shield.";
		sprite_index = sprItemFriendlyShieldNew;
		
		on_turn_start = function() {
			interface.block(block);
		}
	}
})

ITEMS.REVIVE_TURN_START = register_item("ReviveTurnStart", function() {
	with new Item() {
		name = "Photographic Memory";
		revive_count = 5;
		desc = $"At the start of your turn,\nRebuild {revive_count} bricks."
		sprite_index = sprItemPhotographicMemory;
		
		on_turn_start = function() {
			interface.consume(new RespawnItem(self, revive_count));
		}
	}
})