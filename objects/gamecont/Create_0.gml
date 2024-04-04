/// @description Insert description here
// You can write your code in this editor

randomize()

global.money = 10000

global.wasUsingEditor = false

global.rounds = 0
global.round = 0
global.levels = ds_list_create()

for (var i = 0; i < array_length(global.levelData); i++) {
	ds_list_add(global.levels, i)
}
ds_list_shuffle(global.levels)

delays = ds_list_create()

schedule(20, function() {encounter_start()})

alarm[0] = room_speed * 30;