function button_pressed(inputName) {
	return getInput(inputName, inputTypes.pressed);
}

function button_check(inputName) {
	return getInput(inputName, inputTypes.check);
}

function button_released(inputName) {
	return getInput(inputName, inputTypes.released);
}

/// @ignore
function get_input_keys(input) {
	static keys = memoize_array(inputs.MAX, function(i) {
		switch (i) {
			case (inputs.use):
				return ["E", vk_enter, vk_space]
			case (inputs.up):
				return ["W", vk_up]
			case (inputs.down):
				return ["S", vk_down]
			case (inputs.right):
				return ["D", vk_right]
			case (inputs.left):
				return ["A", vk_left]
				
			case(inputs.turn_left):
				return ["Q"];
			case(inputs.turn_right):
				return ["E"];
				
			case(inputs.editor_cycle):
				return [vk_left, vk_right]
			case(inputs.editor_left):
				return [vk_left]
			case(inputs.editor_right):
				return [vk_right]
			case(inputs.editor_clear):
				return [vk_delete]
			case(inputs.editor_save):
				return [vk_enter]
			case(inputs.editor_new):
				return ["N"]
			case(inputs.editor_reload):
				return ["T"]
			case(inputs.editor_translate_down):
				return [vk_down]
			case(inputs.editor_translate_up):
				return [vk_up]
			case(inputs.editor_modifier):
				return [vk_shift]
			case(inputs.editor_color_mode):
				return ["C"]
			case (inputs.editor_objects):
				return [vk_tab]
			case (inputs.editor_info):
				return ["`"]
		
			case (inputs.menu_use):
				return [mb_left]
			case (inputs.mouse_right):
				return [mb_right];
			case (inputs.menu_select):
				return [mb_middle];
			
			case(inputs.shoot):
				return [mb_left];
			case(inputs.dash):
				return [vk_space, mb_right]
				
			case (inputs.inspect):
				return [vk_alt];
		}
	});
	
	return keys[input];	
}

/// @ignore
function getInput(inputName, inputType) {
	
	if instance_exists(obj_text_prompt) return false
	
	var keys = get_input_keys(inputName);	
	
	for (var i = 0; i < array_length(keys); i++) {
		if check_button(keys[i], inputType) return true
	}
	return false
}

/// @ignore
function check_button(input, inputType) {
	if is_string(input) {
		return get_key_function(ord(input), inputType)
	}
	if input == mb_left || input == mb_right || input = mb_middle {
		return get_mouse_function(input, inputType)
	}
	else return get_key_function(input, inputType)
}

/// @ignore
function get_key_function(input, inputType) {
	switch(inputType) {
		case(inputTypes.pressed):
			return keyboard_check_pressed(input)
		case(inputTypes.check):
			return keyboard_check(input)
		case(inputTypes.released):
			return keyboard_check_released(input)
	}
}

/// @ignore
function get_mouse_function(input, inputType) {
	switch(inputType) {
		case(inputTypes.pressed):
			return mouse_check_button_pressed(input)
		case(inputTypes.check):
			return mouse_check_button(input)
		case(inputTypes.released):
			return mouse_check_button_released(input)
	}
}

enum inputs {
	up,
	down,
	left,
	right,
	use,
	shoot,
	dash,
	menu_use,
	mouse_right,
	menu_select,
	turn_left,
	turn_right,
	
	editor_save,
	editor_cycle,
	editor_left,
	editor_right,
	editor_clear,
	editor_new,
	editor_reload,
	editor_translate_up,
	editor_translate_down,
	editor_modifier,
	editor_color_mode,
	editor_objects,
	editor_info,
	
	inspect,
	
	MAX
}

enum inputTypes {
	pressed,
	check,
	released,
}