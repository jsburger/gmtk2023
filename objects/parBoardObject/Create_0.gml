/// @description 

#macro flip image_xscale *= choose(-1, 1)
#macro dont_flip image_xscale = abs(image_xscale)
#macro shuffle image_index = irandom(image_number - 1)

#region Fade in
	is_visible = true;

	if instance_exists(obj_board) {
		visible = false
		alarm[0] = 1
	}
	
#endregion

#region Pausing
	paused = false
	#macro board_object_exit if paused exit
#endregion

#region Serializing
	serializer = new Serializer(self);

#endregion

#region Coloring
	colorable = false;
	color = MANA_NONE;

	set_color = function(col) {
		if !is_valid_color(col) exit
		color = col
		image_blend = mana_get_color(col)
	}
	
	serializer.add_layer("color",
		function() {
			if is_valid_color(color) && color > MANA_NONE return color;
		},
		function(data) {set_color(data)}
	)
	
#endregion

#region Ball Logic
	#region Collision
		can_collide = true;
		
		can_ball_collide = function(ball) {
			return true;
		}
		
		can_walk_back_ball = true;
		/// Called ONLY to move the ball upon impact. Do NOT add sound effects here.
		ball_bounce = function(ball) {}
		/// Called after bouncing. Used for things like Effects
		on_ball_impact = function(ball, collision_x, collision_y) {}

		snd_impact = sndDieHitBrick;
		#region Damage
			can_take_damage = false;
			hp = 1;
			
			on_hurt = function(damage) {};
		
		#endregion
	ghost_hits = 0; //Used to track how many times a ghost has collided with an instance.
	stops_preview = true;
	fullclear_ignore = false; // If an object can take damage, but shouldn't count against full clears.
	#endregion
	
#endregion

#region Statuses
	#region Freeze
		can_freeze = false;
		spr_frozen = sprBrickOverlayFrozen;
		spr_frozen_index = 0;
		is_frozen = false;
		/// Cleaning prevents the function from calling brick_unfreeze, which would create a loop
		set_frozen = function(value, cleaning = false) {
			if value != is_frozen {
				is_frozen = value;
				if is_frozen {
					spr_frozen_index = irandom(sprite_get_number(spr_frozen) - 1);
				}
				else if !cleaning {
					brick_on_unfreeze(self)
				}
			}
		}
		
		function setup_freeze(sprite) {
			can_freeze = true;
			spr_frozen = sprite
		}
		
	#endregion
	
	#region Burn
		can_burn = false;
	#endregion
	
	#region Poison
		can_poison = false;
	#endregion
	
#endregion

#region Timeline Hints
	timeline_entry = undefined;
#endregion

#region Round integration
	on_round_end = undefined;
#endregion