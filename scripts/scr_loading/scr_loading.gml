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

//function level_init_old(){
//	global.level_data = [];
//	global.level_num = 0;
//	// Make sure to use @' ', not " "!
	
//	// REAL ONES
//	/*Karm*/array_push(global.level_data,@'{ "4": { "x": 448.0, "y": 496.0, "object_index": "obj_switch_on_d" }, "121": { "x": 360.0, "y": 552.0, "object_index": "obj_bridge_u" }, "100": { "x": 288.0, "y": 504.0, "object_index": "obj_and_gate_left" }, "88": { "x": 312.0, "y": 488.0, "object_index": "obj_cable_h" }, "178": { "x": 336.0, "y": 512.0, "object_index": "obj_block_metal_v" }, "14": { "x": 248.0, "y": 568.0, "object_index": "obj_cable_ru" }, "136": { "x": 520.0, "y": 584.0, "object_index": "obj_cable_h" }, "152": { "x": 488.0, "y": 520.0, "object_index": "obj_cable_h" }, "129": { "x": 328.0, "y": 536.0, "object_index": "obj_cable_h" }, "116": { "x": 504.0, "y": 600.0, "object_index": "obj_cable_h" }, "80": { "x": 312.0, "y": 552.0, "object_index": "obj_cable_h" }, "79": { "x": 296.0, "y": 552.0, "object_index": "obj_cable_h" }, "146": { "x": 376.0, "y": 504.0, "object_index": "obj_cable_h" }, "89": { "x": 328.0, "y": 488.0, "object_index": "obj_cable_h" }, "3": { "x": 384.0, "y": 496.0, "object_index": "obj_switch_on_d" }, "180": { "x": 336.0, "y": 384.0, "object_index": "obj_block_metal_v" }, "115": { "x": 488.0, "y": 600.0, "object_index": "obj_cable_h" }, "162": { "x": 456.0, "y": 504.0, "object_index": "obj_cable_v" }, "130": { "x": 344.0, "y": 536.0, "object_index": "obj_cable_h" }, "184": { "x": 496.0, "y": 384.0, "object_index": "obj_block_metal_v" }, "109": { "x": 440.0, "y": 520.0, "object_index": "obj_cable_v" }, "181": { "x": 336.0, "y": 320.0, "object_index": "obj_block_metal_v" }, "62": { "x": 592.0, "y": 536.0, "object_index": "obj_and_gate_right" }, "76": { "x": 344.0, "y": 584.0, "object_index": "obj_cable_h" }, "5": { "x": 448.0, "y": 464.0, "object_index": "obj_switch_on_d" }, "59": { "x": 600.0, "y": 552.0, "object_index": "obj_cable_v" }, "9": { "x": 264.0, "y": 552.0, "object_index": "obj_cable_v" }, "49": { "x": 232.0, "y": 536.0, "object_index": "obj_cable_v" }, "138": { "x": 520.0, "y": 552.0, "object_index": "obj_cable_h" }, "169": { "x": 448.0, "y": 560.0, "object_index": "obj_switch_on_d" }, "98": { "x": 376.0, "y": 520.0, "object_index": "obj_cable_h" }, "68": { "x": 392.0, "y": 488.0, "object_index": "obj_cable_lu" }, "120": { "x": 568.0, "y": 600.0, "object_index": "obj_cable_h" }, "54": { "x": 584.0, "y": 568.0, "object_index": "obj_cable_lu" }, "137": { "x": 536.0, "y": 584.0, "object_index": "obj_cable_h" }, "128": { "x": 312.0, "y": 536.0, "object_index": "obj_cable_h" }, "144": { "x": 544.0, "y": 568.0, "object_index": "obj_and_gate_right" }, "90": { "x": 344.0, "y": 488.0, "object_index": "obj_cable_h" }, "157": { "x": 504.0, "y": 584.0, "object_index": "obj_cable_h" }, "173": { "x": 496.0, "y": 640.0, "object_index": "obj_block_metal_v" }, "159": { "x": 488.0, "y": 584.0, "object_index": "obj_cable_h" }, "125": { "x": 344.0, "y": 568.0, "object_index": "obj_cable_h" }, "188": { "x": 384.0, "y": 239.999969482421875, "object_index": "obj_block_metal" }, "52": { "x": 584.0, "y": 520.0, "object_index": "obj_cable_v" }, "87": { "x": 280.0, "y": 504.0, "object_index": "obj_cable_h" }, "85": { "x": 280.0, "y": 568.0, "object_index": "obj_cable_h" }, "99": { "x": 288.0, "y": 568.0, "object_index": "obj_and_gate_left" }, "11": { "x": 264.0, "y": 600.0, "object_index": "obj_cable_ru" }, "46": { "x": 232.0, "y": 488.0, "object_index": "obj_cable_v" }, "134": { "x": 328.0, "y": 504.0, "object_index": "obj_cable_h" }, "151": { "x": 472.0, "y": 520.0, "object_index": "obj_cable_h" }, "26": { "x": 376.0, "y": 600.0, "object_index": "obj_cable_h" }, "183": { "x": 496.0, "y": 448.0, "object_index": "obj_block_metal_v" }, "16": { "x": 248.0, "y": 520.0, "object_index": "obj_cable_v" }, "182": { "x": 496.0, "y": 512.0, "object_index": "obj_block_metal_v" }, "48": { "x": 232.0, "y": 520.0, "object_index": "obj_cable_v" }, "81": { "x": 328.0, "y": 552.0, "object_index": "obj_cable_h" }, "65": { "x": 392.0, "y": 584.0, "object_index": "obj_cable_lu" }, "28": { "x": 408.0, "y": 600.0, "object_index": "obj_cable_h" }, "73": { "x": 296.0, "y": 584.0, "object_index": "obj_cable_h" }, "133": { "x": 312.0, "y": 504.0, "object_index": "obj_cable_h" }, "8": { "x": 264.0, "y": 568.0, "object_index": "obj_bridge_d" }, "50": { "x": 584.0, "y": 600.0, "object_index": "obj_cable_h" }, "61": { "x": 600.0, "y": 600.0, "object_index": "obj_cable_lu" }, "156": { "x": 504.0, "y": 552.0, "object_index": "obj_cable_h" }, "21": { "x": 296.0, "y": 600.0, "object_index": "obj_cable_h" }, "164": { "x": 456.0, "y": 488.0, "object_index": "obj_cable_ru" }, "155": { "x": 488.0, "y": 552.0, "object_index": "obj_cable_h" }, "72": { "x": 392.0, "y": 568.0, "object_index": "obj_cable_v" }, "176": { "x": 336.0, "y": 640.0, "object_index": "obj_block_metal_v" }, "69": { "x": 392.0, "y": 472.0, "object_index": "obj_cable_v" }, "149": { "x": 488.0, "y": 488.0, "object_index": "obj_cable_h" }, "143": { "x": 536.0, "y": 488.0, "object_index": "obj_cable_h" }, "140": { "x": 520.0, "y": 520.0, "object_index": "obj_cable_h" }, "119": { "x": 552.0, "y": 600.0, "object_index": "obj_cable_h" }, "47": { "x": 232.0, "y": 504.0, "object_index": "obj_cable_v" }, "0": { "x": 448.0, "y": 288.0, "object_index": "obj_portal_5" }, "122": { "x": 312.0, "y": 520.0, "object_index": "obj_bridge_d" }, "1": { "x": 384.0, "y": 288.0, "object_index": "obj_portal" }, "95": { "x": 328.0, "y": 520.0, "object_index": "obj_cable_h" }, "127": { "x": 376.0, "y": 568.0, "object_index": "obj_cable_h" }, "66": { "x": 392.0, "y": 552.0, "object_index": "obj_cable_lu" }, "96": { "x": 344.0, "y": 520.0, "object_index": "obj_cable_h" }, "112": { "x": 440.0, "y": 568.0, "object_index": "obj_cable_v" }, "177": { "x": 336.0, "y": 576.0, "object_index": "obj_block_metal_v" }, "51": { "x": 584.0, "y": 552.0, "object_index": "obj_cable_v" }, "44": { "x": 232.0, "y": 456.0, "object_index": "obj_cable_rd" }, "29": { "x": 424.0, "y": 600.0, "object_index": "obj_cable_h" }, "53": { "x": 584.0, "y": 504.0, "object_index": "obj_cable_ld" }, "124": { "x": 328.0, "y": 568.0, "object_index": "obj_cable_h" }, "185": { "x": 496.0, "y": 320.0, "object_index": "obj_block_metal_v" }, "43": { "x": 248.0, "y": 456.0, "object_index": "obj_cable_h" }, "161": { "x": 456.0, "y": 536.0, "object_index": "obj_cable_v" }, "103": { "x": 360.0, "y": 488.0, "object_index": "obj_bridge_d" }, "97": { "x": 360.0, "y": 520.0, "object_index": "obj_cable_h" }, "108": { "x": 440.0, "y": 504.0, "object_index": "obj_cable_v" }, "145": { "x": 544.0, "y": 504.0, "object_index": "obj_and_gate_right" }, "75": { "x": 328.0, "y": 584.0, "object_index": "obj_cable_h" }, "10": { "x": 264.0, "y": 584.0, "object_index": "obj_cable_v" }, "78": { "x": 376.0, "y": 584.0, "object_index": "obj_cable_h" }, "91": { "x": 360.0, "y": 488.0, "object_index": "obj_cable_h" }, "39": { "x": 312.0, "y": 456.0, "object_index": "obj_cable_h" }, "126": { "x": 360.0, "y": 568.0, "object_index": "obj_cable_h" }, "153": { "x": 504.0, "y": 520.0, "object_index": "obj_cable_h" }, "24": { "x": 344.0, "y": 600.0, "object_index": "obj_cable_h" }, "160": { "x": 456.0, "y": 568.0, "object_index": "obj_cable_v" }, "41": { "x": 280.0, "y": 456.0, "object_index": "obj_cable_h" }, "187": { "x": 336.0, "y": 255.999969482421875, "object_index": "obj_block_metal_v" }, "40": { "x": 296.0, "y": 456.0, "object_index": "obj_cable_h" }, "34": { "x": 392.0, "y": 456.0, "object_index": "obj_cable_h" }, "189": { "x": 448.0, "y": 239.999969482421875, "object_index": "obj_block_metal" }, "110": { "x": 440.0, "y": 536.0, "object_index": "obj_cable_v" }, "114": { "x": 472.0, "y": 600.0, "object_index": "obj_cable_h" }, "60": { "x": 600.0, "y": 536.0, "object_index": "obj_cable_v" }, "56": { "x": 568.0, "y": 504.0, "object_index": "obj_cable_h" }, "105": { "x": 552.0, "y": 568.0, "object_index": "obj_cable_h" }, "18": { "x": 264.0, "y": 568.0, "object_index": "obj_cable_h" }, "35": { "x": 376.0, "y": 456.0, "object_index": "obj_cable_h" }, "86": { "x": 296.0, "y": 488.0, "object_index": "obj_cable_h" }, "23": { "x": 312.0, "y": 600.0, "object_index": "obj_cable_h" }, "38": { "x": 328.0, "y": 456.0, "object_index": "obj_cable_h" }, "167": { "x": 456.0, "y": 584.0, "object_index": "obj_cable_ru" }, "171": { "x": 448.0, "y": 608.0, "object_index": "obj_portal" }, "37": { "x": 344.0, "y": 456.0, "object_index": "obj_cable_h" }, "163": { "x": 456.0, "y": 472.0, "object_index": "obj_cable_v" }, "132": { "x": 376.0, "y": 536.0, "object_index": "obj_cable_h" }, "165": { "x": 456.0, "y": 520.0, "object_index": "obj_cable_ru" }, "13": { "x": 280.0, "y": 536.0, "object_index": "obj_cable_h" }, "19": { "x": 264.0, "y": 504.0, "object_index": "obj_cable_h" }, "15": { "x": 248.0, "y": 504.0, "object_index": "obj_cable_rd" }, "106": { "x": 440.0, "y": 472.0, "object_index": "obj_cable_v" }, "139": { "x": 536.0, "y": 552.0, "object_index": "obj_cable_h" }, "64": { "x": 296.0, "y": 536.0, "object_index": "obj_cable_h" }, "20": { "x": 280.0, "y": 600.0, "object_index": "obj_cable_h" }, "107": { "x": 440.0, "y": 488.0, "object_index": "obj_cable_v" }, "84": { "x": 376.0, "y": 552.0, "object_index": "obj_cable_h" }, "104": { "x": 552.0, "y": 504.0, "object_index": "obj_cable_h" }, "32": { "x": 424.0, "y": 456.0, "object_index": "obj_cable_h" }, "168": { "x": 448.0, "y": 528.0, "object_index": "obj_switch_on_d" }, "83": { "x": 360.0, "y": 552.0, "object_index": "obj_cable_h" }, "175": { "x": 384.0, "y": 656.0, "object_index": "obj_block_metal" }, "141": { "x": 536.0, "y": 520.0, "object_index": "obj_cable_h" }, "117": { "x": 520.0, "y": 600.0, "object_index": "obj_cable_h" }, "131": { "x": 360.0, "y": 536.0, "object_index": "obj_cable_h" }, "2": { "x": 384.0, "y": 464.0, "object_index": "obj_switch_on_d" }, "6": { "x": 384.0, "y": 528.0, "object_index": "obj_switch_on_d" }, "30": { "x": 440.0, "y": 600.0, "object_index": "obj_cable_h" }, "147": { "x": 360.0, "y": 504.0, "object_index": "obj_cable_h" }, "102": { "x": 360.0, "y": 472.0, "object_index": "obj_cable_h" }, "179": { "x": 336.0, "y": 448.0, "object_index": "obj_block_metal_v" }, "12": { "x": 264.0, "y": 536.0, "object_index": "obj_cable_rd" }, "92": { "x": 376.0, "y": 488.0, "object_index": "obj_cable_h" }, "27": { "x": 392.0, "y": 600.0, "object_index": "obj_cable_h" }, "57": { "x": 600.0, "y": 584.0, "object_index": "obj_cable_v" }, "111": { "x": 440.0, "y": 552.0, "object_index": "obj_cable_v" }, "135": { "x": 344.0, "y": 504.0, "object_index": "obj_cable_h" }, "25": { "x": 360.0, "y": 600.0, "object_index": "obj_cable_h" }, "154": { "x": 472.0, "y": 552.0, "object_index": "obj_cable_h" }, "70": { "x": 392.0, "y": 504.0, "object_index": "obj_cable_v" }, "166": { "x": 456.0, "y": 552.0, "object_index": "obj_cable_ru" }, "77": { "x": 360.0, "y": 584.0, "object_index": "obj_cable_h" }, "123": { "x": 312.0, "y": 568.0, "object_index": "obj_cable_h" }, "67": { "x": 392.0, "y": 520.0, "object_index": "obj_cable_lu" }, "74": { "x": 312.0, "y": 584.0, "object_index": "obj_cable_h" }, "101": { "x": 376.0, "y": 472.0, "object_index": "obj_cable_h" }, "71": { "x": 392.0, "y": 536.0, "object_index": "obj_cable_v" }, "82": { "x": 344.0, "y": 552.0, "object_index": "obj_cable_h" }, "174": { "x": 448.0, "y": 656.0, "object_index": "obj_block_metal" }, "17": { "x": 248.0, "y": 552.0, "object_index": "obj_cable_v" }, "158": { "x": 472.0, "y": 584.0, "object_index": "obj_cable_h" }, "186": { "x": 496.0, "y": 255.999969482421875, "object_index": "obj_block_metal_v" }, "31": { "x": 440.0, "y": 456.0, "object_index": "obj_cable_ld" }, "22": { "x": 328.0, "y": 600.0, "object_index": "obj_cable_h" }, "93": { "x": 296.0, "y": 520.0, "object_index": "obj_cable_h" }, "58": { "x": 600.0, "y": 568.0, "object_index": "obj_cable_v" }, "42": { "x": 264.0, "y": 456.0, "object_index": "obj_cable_h" }, "172": { "x": 496.0, "y": 576.0, "object_index": "obj_block_metal_v" }, "150": { "x": 504.0, "y": 488.0, "object_index": "obj_cable_h" }, "7": { "x": 384.0, "y": 560.0, "object_index": "obj_switch_on_d" }, "148": { "x": 472.0, "y": 488.0, "object_index": "obj_cable_h" }, "36": { "x": 360.0, "y": 456.0, "object_index": "obj_cable_h" }, "170": { "x": 384.0, "y": 608.0, "object_index": "obj_portal_5" }, "142": { "x": 520.0, "y": 488.0, "object_index": "obj_cable_h" }, "118": { "x": 536.0, "y": 600.0, "object_index": "obj_cable_h" }, "55": { "x": 568.0, "y": 568.0, "object_index": "obj_cable_h" }, "113": { "x": 456.0, "y": 600.0, "object_index": "obj_cable_h" }, "94": { "x": 312.0, "y": 520.0, "object_index": "obj_cable_h" }, "45": { "x": 232.0, "y": 472.0, "object_index": "obj_cable_v" }, "63": { "x": 240.0, "y": 536.0, "object_index": "obj_and_gate_left" }, "33": { "x": 408.0, "y": 456.0, "object_index": "obj_cable_h" } }
//');
//	/**///array_push(global.level_data,@'');
//	/*Karm Portal Launch*/array_push(global.level_data,@'{ "51": { "x": 640.0, "y": 528.0, "object_index": "obj_block_large" }, "30": { "x": 496.0, "y": 488.0, "object_index": "obj_block" }, "37": { "x": 368.0, "y": 456.0, "object_index": "obj_block" }, "8": { "x": 336.0, "y": 360.0, "object_index": "obj_cash_wad" }, "23": { "x": 400.0, "y": 536.0, "object_index": "obj_block" }, "24": { "x": 368.0, "y": 520.0, "object_index": "obj_block" }, "43": { "x": 464.0, "y": 424.0, "object_index": "obj_block" }, "3": { "x": 240.0, "y": 296.0, "object_index": "obj_block" }, "39": { "x": 496.0, "y": 424.0, "object_index": "obj_block" }, "42": { "x": 368.0, "y": 424.0, "object_index": "obj_block" }, "21": { "x": 464.0, "y": 520.0, "object_index": "obj_block" }, "46": { "x": 192.0, "y": 320.0, "object_index": "obj_block_large" }, "2": { "x": 240.0, "y": 264.0, "object_index": "obj_block" }, "31": { "x": 464.0, "y": 488.0, "object_index": "obj_block" }, "22": { "x": 432.0, "y": 536.0, "object_index": "obj_block" }, "7": { "x": 592.0, "y": 296.0, "object_index": "obj_block" }, "4": { "x": 688.0, "y": 296.0, "object_index": "obj_block" }, "1": { "x": 144.0, "y": 296.0, "object_index": "obj_block" }, "38": { "x": 336.0, "y": 424.0, "object_index": "obj_block" }, "28": { "x": 336.0, "y": 488.0, "object_index": "obj_block" }, "18": { "x": 464.0, "y": 392.0, "object_index": "obj_block" }, "16": { "x": 496.0, "y": 520.0, "object_index": "obj_block" }, "35": { "x": 464.0, "y": 456.0, "object_index": "obj_block" }, "19": { "x": 336.0, "y": 392.0, "object_index": "obj_block" }, "41": { "x": 432.0, "y": 440.0, "object_index": "obj_block" }, "25": { "x": 336.0, "y": 520.0, "object_index": "obj_block" }, "32": { "x": 400.0, "y": 472.0, "object_index": "obj_block" }, "48": { "x": 640.0, "y": 272.0, "object_index": "obj_coin_pouch" }, "15": { "x": 496.0, "y": 552.0, "object_index": "obj_block" }, "40": { "x": 400.0, "y": 440.0, "object_index": "obj_block" }, "29": { "x": 368.0, "y": 488.0, "object_index": "obj_block" }, "5": { "x": 688.0, "y": 264.0, "object_index": "obj_block" }, "55": { "x": 192.0, "y": 480.0, "object_index": "obj_portal" }, "12": { "x": 336.0, "y": 552.0, "object_index": "obj_block" }, "56": { "x": 640.0, "y": 608.0, "object_index": "obj_bumper" }, "27": { "x": 432.0, "y": 504.0, "object_index": "obj_block" }, "49": { "x": 640.0, "y": 320.0, "object_index": "obj_block_large" }, "14": { "x": 464.0, "y": 552.0, "object_index": "obj_block" }, "36": { "x": 336.0, "y": 456.0, "object_index": "obj_block" }, "45": { "x": 432.0, "y": 408.0, "object_index": "obj_block" }, "53": { "x": 192.0, "y": 560.0, "object_index": "obj_block_large" }, "57": { "x": 192.0, "y": 608.0, "object_index": "obj_bumper" }, "0": { "x": 144.0, "y": 264.0, "object_index": "obj_block" }, "6": { "x": 592.0, "y": 264.0, "object_index": "obj_block" }, "10": { "x": 432.0, "y": 456.0, "object_index": "obj_cash_wad" }, "9": { "x": 496.0, "y": 360.0, "object_index": "obj_cash_wad" }, "26": { "x": 400.0, "y": 504.0, "object_index": "obj_block" }, "20": { "x": 368.0, "y": 392.0, "object_index": "obj_block" }, "54": { "x": 640.0, "y": 480.0, "object_index": "obj_portal" }, "17": { "x": 496.0, "y": 392.0, "object_index": "obj_block" }, "44": { "x": 400.0, "y": 408.0, "object_index": "obj_block" }, "13": { "x": 368.0, "y": 552.0, "object_index": "obj_block" }, "34": { "x": 496.0, "y": 456.0, "object_index": "obj_block" }, "52": { "x": 192.0, "y": 528.0, "object_index": "obj_block_large" }, "33": { "x": 432.0, "y": 472.0, "object_index": "obj_block" }, "47": { "x": 192.0, "y": 272.0, "object_index": "obj_coin_pouch" }, "50": { "x": 640.0, "y": 560.0, "object_index": "obj_block_large" }, "11": { "x": 400.0, "y": 456.0, "object_index": "obj_cash_wad" } }');
		
//	for(var i = 0;i<array_length(global.level_data);i++){
//		global.level_data[@i] = json_parse(global.level_data[i]);
//	}	
//}

//function level_load_old(_i){
//	if !range(_i, 0, array_length(global.level_data) - 1) exit;
//	var _keys = variable_struct_get_names(global.level_data[_i]);
//	for(var i = 0;i<array_length(_keys);i++){
//		var _struct = variable_struct_get(global.level_data[_i],_keys[i]);
//		with(instance_create_layer(_struct.x, _struct.y, "Instances", asset_get_index(_struct.object_index))){
//			if object_is_ancestor(object_index, obj_cable) obj_layer = 1 else obj_layer = 0;
//		}
//	}
//	with par_bricklike event_perform(ev_other, ev_user15);
//}

