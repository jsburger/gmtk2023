{
	image_index = 0;
	if sprite_index == sprSandwichPopupAppear{
		sprite_index = sprSandwichPopupLoop;	
	}
	if sprite_index = sprSandwichPopupDisappear{
		instance_destroy();
		exit;
	}
}