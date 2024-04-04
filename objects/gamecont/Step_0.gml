/// @description Insert description here
// You can write your code in this editor


if !instance_exists(obj_fullclear_maker) {
	//Check queue for active voiceline
	var voice = get_voiceline_queue().top();

	//If there is nothing in the queue, or if the voiceline is unimportant, keep progressing.
	if (is_undefined(voice) || !voice.important) {
		for (var i = 0; i < ds_list_size(delays); i++) {
			var o = delays[| i];
			o.time -= 1;
			if o.time <= 0 {
				o.func()
				ds_list_delete(delays, i)
				i--
			}
		}
	}
}