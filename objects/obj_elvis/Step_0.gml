/// @description Process lines

if wait wait -= 1

if waitforvoiceline > 0 {
	waitforvoiceline -= 1
	if waitforvoiceline <= 0 {
		if room == intro_room{
			say_line(voIntro, function() {
				with instance_create_depth(x, y, depth + 2, FadeTo) {
					destination = a_roominit;
				}
			})
		}else if room == end_room{
			var _win = true;
			say_line(_win ? voEndgameWin : voEndgaemLose, function() {
					game_end();
				}
			);
		}
	}
}

if progress < 1 && wait <= 0 && false {
	progress += .025
	waitforvoiceline = 60
}
image_xscale = lerp(xscale, 1,sqr(progress))
image_yscale = lerp(yscale, 1,sqr(progress))


if true {
	if progress < 1 && elvis_is_speaking() {
		progress += .05
		progress = min(progress, 1)
	}
	if progress > 0 && !elvis_is_speaking(){
		progress -= .05
	}
}

//x = xstart - talking_x * lean
with obj_elvis_name {
	image_xscale = other.image_xscale
	image_yscale = other.image_yscale
}
