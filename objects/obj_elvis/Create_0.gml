/// @description 

xscale = 0
yscale = 8
progress = 0
waitforvoiceline = 0
wait = 60

lean = 0
talking_x = 300
//xstart += talking_x

if room == intro_room {
	sound_play_pitch(sndFutureElvisAppear, 1.23)
}
global.elvis_done = false

alarm[0] = 60 * room_speed