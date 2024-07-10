/// @description 

buttons = 0;
queue = [];
alarm[0] = -1;
delay = .15 sec;

add_button = function(ability) {
	array_push(queue, ability)
	if alarm[0] == -1 alarm[0] = delay;
}

array_foreach(global.player_stats.abilities, function(item) {
	add_button(item)
})