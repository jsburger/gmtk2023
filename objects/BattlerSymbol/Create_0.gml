/// @description 

// Inherit the parent event
event_inherited();
set_hp(20)

movemode = moveOrder.LINEAR

change_form = function(color) {
	form = color;
	sprite_index = sprSentientSymbolTransform;
	image_index = 0;
}
change_form(var_defget(self, "form", MANA.RED))

var count_blocks = function() {
	var n = 0;
	with obj_block if color == other.form {
		n++
	};
	return n;
}
var get_form = function() {
	return form;
}
with add_action("SYMBOL SLAM!!!") {
	var damage = as_damage(new FunctionProvider(count_blocks));
	set_intent(INTENT.ATTACK, damage)
	hit(damage)
	var _form = accept_provider(new FunctionProvider(get_form));
	color(5, _form)
	desc = "Deal Damage equal to the \namount of Matching bricks.\nRecolor 5 bricks to \nMatching color."
}

on_turn_end = function() {
	CombatRunner.waitTime += 10;
	var c = irandom(MANA.MAX - 1);
	while c == form {
		c = irandom(MANA.MAX - 1);
	}
	change_form(c);
}