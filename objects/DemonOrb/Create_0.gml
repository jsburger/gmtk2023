/// @description 

// Inherit the parent event
event_inherited();

ball_bounce = method(self, bounce_circular);
on_ball_impact = method(self, impact_normal);

timeline_entry = new TimelineBoardNote(sprite_index,
	"At the end of the turn,\nDemon Orbs recolor\n8 bricks PURPLE.")
timeline_entry.highlight_object = object_index

brick_sorter = function(a, b) {
	var a_dist = distance_to_object(a),
		b_dist = distance_to_object(b);
	if a_dist < b_dist return SORTING.BEFORE;
	if a_dist > b_dist return SORTING.AFTER;
	return SORTING.EQUAL;
}
on_round_end = function() {
	static interface = new CombatInterface();
	interface.recolor(8, COLORS.PURPLE).sorter = brick_sorter;
}