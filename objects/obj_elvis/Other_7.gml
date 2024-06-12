/// @description Stop saying line

//Goes off when talk_end is done.
if global.elvis_done == true {
	global.elvis_done = false
	stop_saying_line()
}


sprite_index = getNextSprite(sprite_index)
image_index = 0
