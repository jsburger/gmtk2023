/// @description 

image_blend = c_gray;
if instance_exists(CombatRunner) && !throw_active() {
	if CombatRunner.throws == 0 image_blend = c_white;
}