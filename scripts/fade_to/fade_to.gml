function fade_to(_room){
	with instance_create_layer(0, 0, "Portraits", FadeTo) {
		destination = _room
		
		return self;
	}
}