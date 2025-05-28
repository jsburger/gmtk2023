/// @description Draw Current Spell
//if targeting && current_ability != undefined {
//	var button = noone;
//	with AbilityButton if active {
//		button = self
//		break
//	}
//	var clickable = get_hovered_clickable(),
//		info = {type : TARGET_TYPE.NONE };
//	if instance_exists(clickable) {
//		if variable_instance_exists(clickable, "get_target_info") {
//			info = clickable.get_target_info()
//		}
//	}
//	if instance_exists(button) {
//		current_ability.draw_target(button.bbox_right, button.y, info)
//	}
//	else {
//		current_ability.draw_target(PlayerBattler.bbox_right, PlayerBattler.y, info)
//	}
//}
if is_targeting() {
	current_spell.active_draw();
}