/// @description hiiii!
event_inherited()
if instance_exists(obj_board) {
	visible = false
	alarm[0] = obj_board.editor ?  1 : manhatten_distance(x, y, obj_board.bbox_left, obj_board.bbox_top)/32
}
index = 0;
spr_back = sprPortalBackPurple;
spr_fx = sprFXPortalPurple;

teleport = function(instance, portal = self) {
	var target = -4;
	with obj_portal{
		if(index == portal.index && id != portal.id) target = self;
	}
	
	if instance.object_index != obj_fx{
		portal.sprite_index = sprPortalLipsClose;
		portal.image_index = 0;
		target.sprite_index = sprPortalLipsOpen;
		target.image_index = 0;
	}
	
	if instance_exists(target) {
		if instance.portal != id {
			instance.x = target.x;
			instance.y = target.y;
			instance.portal = target.id;
			return true
		}
	}
	return false
}