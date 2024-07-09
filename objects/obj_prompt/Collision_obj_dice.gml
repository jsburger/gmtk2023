{
	if mask_index == mskNone{
		exit;	
	}
	with(other){
		on_dice_bounce(id)	
	}
	mask_index = mskNone;
	sound_play_pitch(snd_bumper_hit, random_range(0.8,1.2));
	with(obj_prompt){
		mask_index = mskNone;
		sprite_index = sprSandwichPopupButtonDisappear;
	}
	sprite_index = sprSandwichPopupButtonDisappear;
	try{
		on_pick();	
	}catch(_error){
		//	
	}
}