/// @ignore
function mask_prepare(x, y, mask, rotation = 0) {
	with instance_create_layer(x, y, "Instances", Blank) {
		mask_index = mask;
		image_angle = rotation;
		
		return self;
	}
}

function mask_meeting(x, y, mask, collide_with, rotation = 0){
	var ret;
	with mask_prepare(x, y, mask, rotation) {
		ret = place_meeting(x, y, collide_with)
		
		instance_destroy(self)
	}
	return ret;
}

function mask_meeting_list(x, y, mask, collide_with, rotation = 0) {
	var list = ds_list_create();
	with mask_prepare(x, y, mask, rotation) {
		instance_place_list(x, y, collide_with, list, true)
	}
	return list;
}