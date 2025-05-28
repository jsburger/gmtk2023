function TargetedSpell() : Spell() constructor {
	
	static accepts_target = function(inst) {
		return false;
	}
	static on_click = function() {
		var clicked = get_hovered_object();
		if (accepts_target(clicked)) {
			CombatRunner.set_target(clicked);
			cast();
		}
	}
}

/// @param {Real,Struct.Provider,Function} damage
function AttackSpell(damage) : TargetedSpell() constructor {
	damage_value = damage;
	static accepts_target = function(inst) {
		return instance_is(inst, EnemyBattler) && inst.hp > 0;
	}
	
	static active_draw = function() {
		var _x = mouse_x, _y = mouse_y,
			hovered = get_hovered_object();
		if (accepts_target(hovered)) {
			_x = hovered.x;
			_y = hovered.bbox_top + 24;
			draw_sprite_auto(sprAttackTarget, hovered.x, hovered.y);
		}
		
		with AbilityButton if active {
			draw_line_width_color(bbox_right, y, _x, _y, 2, c_white, c_white)
		}
		
		var damage = provider_get(damage_value);
		font_push(fntBig, fa_center, fa_bottom);
		draw_text_transformed(_x, _y, -damage, 1.5, 1.5, 0);
		font_pop();
	}
	
	static act = function() {
		attack(TARGETS.AIMED, damage_value)
	}
}

function PostThrowAttackSpell(damage) : AttackSpell(damage) constructor {
	can_cancel = false;
	triggers_reactions = false;
	
	static cast = function() {
		act();
		after_cast();
		CombatRunner.enqueue_last(new FunctionItem(noone, anonymous(throw_resolve)));
		done();
	}
}