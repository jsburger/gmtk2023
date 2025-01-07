randomize()

levels_init()

function levels_init() {
	global.level_data = [];
	global.level_changed = [];
	global.level_num = 0;
	
		
	var file = file_find_first(working_directory + "Levels/*.txt", 0),
		files = [];
	while (file != "") {
		array_push(files, file)
		file = file_find_next();
	}
		
	file_find_close()

	array_foreach(files, function(filename) {
		
		var json = load_level_file(filename)
		
		if level_update_format(json) {
			level_save(json);
		}
		
		array_push(global.level_data, json)
		array_push(global.level_changed, false)

	})
	
}

#macro FORMAT_CURRENT 2

function level_new_json() {
	return {
		info: {
			name: "",
			format: FORMAT_CURRENT,
			rounds: 3
		},
		objects : []
	}
}

function level_update_format(level) {
	var format_changed = false;
	
	//Format 0 -> 1:
	if !struct_exists(level.info, "format") {
		format_changed = true;
		//Add format
		level.info.format = 1;
		array_foreach(level.objects, function(obj) {
			
			//Make coordinates relative to old board position and size.
			static board_x = 416,
				   board_y = 784;
			obj.x -= board_x;
			obj.y -= board_y;
			
			//If color = -1, it is pointless, so remove the serialization
			if struct_exists(obj, "serialized_info") {
				var s = obj.serialized_info;
				if struct_exists(s, "color") && (s.color == -1) && (struct_names_count(s) == 1){
					struct_remove(obj, "serialized_info")
				}
			}
		})
		//Add default round counter
		level.info.rounds = 5;
	}
	
	// Format 1 -> 2
	if (level.info.format == 1) {
		format_changed = true
		// Brick Refactor
		level.info.format = 2;
		
		array_foreach(level.objects, function(obj) {
			// Migrate from serialzied_info to data
			if struct_exists(obj, "serialized_info") {
				var s = obj.serialized_info;
				struct_remove(obj, "serialized_info");
				struct_set(obj, "data", s);
			}
			
			
			// Switch out objects for new ones
			static map = {
				"obj_block": "BrickNormal",
				"obj_block_large": "BrickLarge",
				"obj_block_large_v": "BrickLargeV",
				"obj_block_metal": "BrickLargeMetal",
				"obj_block_metal_v": "BrickLargeMetalV",
				"obj_block_v": "BrickNormalV",
				"obj_bomb": "Bomb",
				"obj_bumper": "Bumper",
				"obj_color_bomb": "ColorBomb",
				"obj_color_bumper": "ColorBumper",
				"obj_super_block": "BrickPipebomb",
				"obj_super_block_v" : "BrickPipebombV"
			}
			
			if struct_exists(map, obj.object_index) {
				obj.object_index = struct_get(map, obj.object_index)
			}
			
			// Special case: Launcher
			if string_count("obj_launcher", obj.object_index) {
				var last = string_replace(obj.object_index, "obj_launcher_", ""),
					dir = 90;
				switch last {
					case "d" : dir = 270; break;
					case "dl": dir = 225; break;
					case "dr": dir = 315; break;
					case "l" : dir = 180; break;
					case "r" : dir =   0; break;
					case "u" : dir =  90; break;
					case "ul": dir = 135; break;
					case "ur": dir =  45; break;
				}
				obj.object_index = "Launcher";
				obj.data = {"launch_direction" : dir};
			}
			
			// Special case: Portal
			if string_count("obj_portal", obj.object_index) {
				var index = string_digits(obj.object_index)
				if string_length(index) > 0 index = real(index);
				else index = 0;
				obj.object_index = "Portal"
				obj.data = {"portal_index" : index}
			}
			
		})
	}
	
	return format_changed;
}


function load_level_file(filename) {
	var buffer = buffer_load(working_directory + "Levels/" + filename),
		str = buffer_read(buffer, buffer_string);
	buffer_delete(buffer)
		
	var json = json_parse(str);
	
	return json;
}


function level_id_by_name(levelName) {
	for (var i = 0; i < array_length(global.level_data); ++i) {
		var l = global.level_data[i];
		if string_lower(l.info.name) == string_lower(levelName) {
			return i
		}
	}
	add_new_level().info.name = levelName;
	return array_length(global.level_data) - 1
}

/// Used in the editor to scroll through boards
function board_cycle(offset = 1) {
	var n = global.level_num + offset
	if offset > 0 {
		n = n mod array_length(global.level_data)
	}
	while n < 0 {
		n += array_length(global.level_data)
	}
	
	global.level_num = n
	level_load(global.level_num);
}

function level_load(levelnumber){	
	if !in_range(levelnumber, 0, array_length(global.level_data) - 1) exit;
	
	global.level_num = levelnumber
	
	generate_brick_tints();
	
	var level = global.level_data[levelnumber];
	
	array_sort(level.objects, function(a, b) {
		if a.y > b.y return -1
		if a.y < b.y return 1
		return 0
	})
	
	
	array_foreach(level.objects, function(entry) {
		var pos = transform_instance_position(entry);
		var obj = asset_get_index(entry.object_index);
		if obj == -1 trace("UNABLE TO FIND OBJECT FOR :" + entry.object_index)
		else with instance_create_layer(pos.x, pos.y, "Instances", obj) {
			//Old
			if instance_is(self, obj_cable) obj_layer = 1
			else obj_layer = 0
			
			//Old
			if variable_struct_exists(entry, "serialized_info") {
				deserialize(entry.serialized_info)
			}
			
			//New
			if variable_struct_exists(entry, "data") {
				serializer.read(entry.data)
			}
			
			if !Board.editor && instance_is(self, parBoardObject) {
				alarm[0] = manhatten_distance(x, y, Board.bbox_left, Board.bbox_top)/32
				if keyboard_check_pressed(vk_home) {
					alarm[0] /= 2;
				}
				on_level_placement.call()
			}
		}
	})
	
	with par_bricklike event_perform(ev_other, ev_user15);
}

function jsonify_board() {
	var objects = [];
	with par_bricklike {
		array_push(objects, jsonify_instance(self))
	}
	with parBoardObject {
		array_push(objects, jsonify_instance(self))
	}
	return {
		"objects" : objects
	}
}

/// Transform World position to or from Board position
function transform_instance_position(inst, storing = false) {
	var r_x = 0,
		r_y = 0;
	var xcheck = 0;
	if instance_exists(Board) {
		xcheck = (Board.bbox_left + Board.bbox_right)/2;
		r_x = ceil(xcheck);
		r_y = round(Board.bbox_bottom);
	}
	
	if storing {
		r_x *= -1;
		r_y *= -1;
	}
	
	return {
		"x" : inst.x + r_x,
		"y" : inst.y + r_y
	}
}

function jsonify_instance(inst) {
	
	var pos = transform_instance_position(inst, true);
	var json = {
		"x": pos.x,
		"y": pos.y,
		"object_index" : object_get_name(inst.object_index)
	}
	// Old
	if variable_instance_exists(inst, "serialize") {
		var s = inst.serialize()
		if s != undefined json.serialized_info = s
	}
	// New
	if variable_instance_exists(inst, "serializer") {
		var s = inst.serializer.write();
		if array_length(struct_get_names(s)) > 0 json.data = s;
		//if s != undefined json.data = s;
	}
	return json
}

#macro current_level global.level_data[global.level_num]

function save_current_level() {
	update_current_level()
	var info = current_level.info;
	if info.name != "" {
		global.level_changed[global.level_num] = false
		level_save(current_level)
	}
	else {
		prompt_input("Save Level As:", function(name) {
			global.level_changed[global.level_num] = false
			current_level.info.name = name
			level_save(current_level)
		})
	}
}
	
function level_save(json) {
	var name = json.info.name;
	
	var f = file_text_open_write(get_save_location() + name + ".txt");		
	show_debug_message(get_save_location() + name + ".txt")

	file_text_write_string(f, json_stringify(json, true));
	file_text_close(f);
}

//Saves level to level data, not to file
function update_current_level() {
	current_level.objects = jsonify_board().objects
}


function add_new_level() {
	var json = level_new_json()
	array_push(global.level_data, json)
	array_push(global.level_changed, true)
	return json
}

function mark_level_changed(changed = true) {
	global.level_changed[global.level_num] = changed
}

function level_clear() {
	with(par_collectible) instance_destroy(self, false);
	with(par_bricklike) instance_destroy(self, false);
	with parBoardObject instance_destroy(self, false);
}

