/// @description 

buttons = 0;
queue = [];
alarm[0] = -1;
delay = .15 sec;

add_button = function(spell) {
	array_push(queue, spell)
	if alarm[0] == -1 alarm[0] = delay;
}

array_foreach(global.player_stats.spells, function(item) {
	add_button(item)
})