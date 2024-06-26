/// @description 

if !instance_exists(target) exit
if display_health != target.hp {
	var dif = display_health - target.hp,
		clmp = abs(dif) > 10 ? .5 : .25;
	display_health -= clamp(dif, -clmp, clmp)
}