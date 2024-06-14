#macro FINAL_BUILD false

global.__save_location = __load_save_location();

/// @ignore
function __load_save_location() {
	var location = working_directory + "SaveLocation.txt";
	if file_exists(location) {
		var buffer = buffer_load(location),
			str = buffer_read(buffer, buffer_string);
		buffer_delete(buffer)
		//Path safety check
		var last = string_last(str);
		if !(last == @"\" || last == "/") {
			str += @"\";
		}
		return str;
	}
	return working_directory + "Levels/";
}

function string_last(str) {
	if string_length(str) == 0 return ""
	return string_char_at(str, string_length(str)) 
}

function get_save_location(){
	if FINAL_BUILD {
		return program_directory + "datafiles/Levels/"
	}
	return global.__save_location;
	
}