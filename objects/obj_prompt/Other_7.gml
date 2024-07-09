{
	image_index = 0;
	if sprite_index == sprSandwichPopupButtonAppear{
		sprite_index = prompt_type == 0 ? sprSandwichPopupButtonYes : sprSandwichPopupButtonNo;
		if !instance_exists(creator){
			sprite_index = sprSandwichPopupButtonDisappear;	
		}
	}
	if sprite_index = sprSandwichPopupButtonYes || sprite_index = sprSandwichPopupButtonNo{
		if !instance_exists(creator) sprite_index = sprSandwichPopupButtonDisappear;	
	}
	if sprite_index = sprSandwichPopupButtonDisappear{
		if instance_exists(creator){
			creator.sprite_index = sprSandwichPopupDisappear;
			creator.image_index = 0;
		}
		instance_destroy();
		exit;
	}
}