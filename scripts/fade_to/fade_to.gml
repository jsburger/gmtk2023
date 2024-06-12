function fade_to(_room){
	with instance_create_layer(0, 0, "Portraits", obj_fade_to) {
		destination = _room
		
		return self;
	}
}