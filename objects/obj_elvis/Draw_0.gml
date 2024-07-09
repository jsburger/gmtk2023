/// @description Teleport animations

draw_sprite_ext(sprPortraitBg, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
draw_self()
draw_sprite_ext(sprPortraitFrame, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)

if progress < 1 {
	var a = lerp(1, 0, sqr(progress))
	gpu_set_fog(true, c_white, 0, 0)
	draw_sprite_ext(sprPortraitBg, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha * a)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha * a)
	draw_sprite_ext(sprPortraitFrame, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha * a)
	gpu_set_fog(false, 0, 0, 0)
}
