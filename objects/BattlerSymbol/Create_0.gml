/// @description 

// Inherit the parent event
event_inherited();
set_hp(15)

movemode = moveOrder.LINEAR
form = var_defget(self, "form", MANA.RED)
change_form = function(color) {
	form = color;
	sprite_index = sprSentientSymbolTransform;
	spr_icon = sprSentientSymbolIconTransform;
	image_index = 0;
}

after_create = function() {
	change_form(form);
}


add_action("SYMBOL SLAM!!!", function() {
	var count_blocks = function() {
		return bricks_with_color(form)
	}
	var get_form = function() {
		return form;
	}
	var symbol = self;
	
	MOVESTART
	//var damage = as_damage(new FunctionProvider(count_blocks));
	var damage = as_damage(new FunctionProvider(count_blocks)),
		_form = accept_provider(new FunctionProvider(get_form));
		
	hit(damage)
	with add_intent(new Intent(new ColoredSprite(_form, sprIntentAttackGray), damage)) {
		desc = format("Deal Damage equal to the \namount of {0} bricks.", new ColorNameProvider(_form));
	}
	
	recolor(5, _form)
	add_intent(new RecolorIntent(5, _form));
	wait(25)
	//desc = "Deal Damage equal to the \namount of Matching bricks.\nRecolor 5 bricks to \nMatching color."
	MOVEEND
})

on_turn_end = function() {
	CombatRunner.waitTime += 10;
	var c = irandom(MANA.MAX - 1);
	while c == form {
		c = irandom(MANA.MAX - 1);
	}
	change_form(c);
}