/// @ignore
/// @returns {Array<Struct.Item>}
function get_item_array() {
	// Feather disable once GM1045
	return [];
}

global.items = get_item_array();
#macro ITEM_LOOP for (var index = 0, l = array_length(global.items), item = array_first(global.items); \
	index < l; item = (l > (++index)) ? global.items[index] : undefined)

function Item() : Hoverable() constructor {
	static last_item = self;
	last_item = self;
	
	name = "Item";
	desc = "Description";
	sprite_index = sprIntentAttack;
	
	interface = new CombatInterface();
	interface.set_owner(self);
	
	static draw = function(x, y) {
		draw_sprite_auto(sprite_index, x, y);
	}
	
	static on_mana_gained = function(type, amount) {};

	static on_turn_start = function() {};
}
