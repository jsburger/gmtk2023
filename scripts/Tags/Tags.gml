
//global.level_starts = new TaggedObjects("LevelStart")
//global.solids = new TaggedObjects("Solid")
//global.projectile_blockers = new TaggedObjects("Obstruction")
global.clickable_objects = new TaggedObjects("Clickable")
global.editor_buttons = new TaggedObjects("EditorButton")
//global.spawners = new TaggedObjects("Spawner")
//global.power_recievers = new TaggedObjects("PowerReciever")
//global.power_emitters  = new TaggedObjects("PowerEmitter")
//global.pausable_objects = new TaggedObjects("Pausable")

function TaggedObjects(_tag) constructor {
    tag = _tag;
    contents = [];
    populate();
    
    static populate = function() {
        var assets = tag_get_asset_ids(tag, asset_object);
        
        //Filter out child objects whos parents already have the tag, to avoid repeated code execution.
        for (var p = 0; p < array_length(assets); p++) {
            for (var c = 0; c < array_length(assets); c++) {
                if (object_is_ancestor(assets[c], assets[p])) {
                    //Remove child object
                    array_delete(assets, c, 1)
                    //Move p and c back one, to account for the array getting shorter
                    if p >= c p -= 1
                    c -= 1
                }
            }
        }
		
		contents = assets
		
    }
    
    static for_each_object = function(callback) {
       for(var i = 0, l = array_length(contents); i < l; i++) {
			with contents[i] {
                callback(self)
            }
        }
    }

	static instances = function() {
		var a = [];
		for(var i = 0, l = array_length(contents); i < l; i++) {
			with contents[i] array_push(a, self)
		}
		return a;
	}
	
	static pos_meeting = function(_x, _y) {
		for(var i = 0, l = array_length(contents); i < l; i++) {
			var p = position_meeting(_x, _y, contents[i])
			if p return p
		}
		return false
	}
	
	static _place_meeting = function(_x, _y, caller) {
		with caller {
			for(var i = 0, l = array_length(other.contents); i < l; i++) {
				var p = place_meeting(_x, _y, other.contents[i])
				if p return p
			}
		}
		return false
	}
}

function place_free_tagged(_x, _y) {
	return !global.projectile_blockers._place_meeting(_x, _y, self)
}

function place_free_bounce(_x, _y){
	var TRUE = false;
	if !place_free_tagged(_x + hspeed, _y){hspeed *= -1; TRUE = true}
	if !place_free_tagged(_x, _y + vspeed){vspeed *= -1; TRUE = true}
	return TRUE;
}

function solid_at(_x, _y) {
	return global.solids.pos_meeting(_x, _y)
}

function proj_block_at(_x, _y) {
	return global.projectile_blockers.pos_meeting(_x, _y)
}

function place_meeting_solid(_x, _y) {
	return global.solids._place_meeting(_x, _y, self)
}

function turret_can_see(x1, y1, x2, y2) {
	var obj = global.projectile_blockers.contents;
	for (var i = 0; i < array_length(obj); ++i) {
	    var p = collision_line(x1, y1, x2, y2, obj[i], true, false);
		if instance_exists(p) return false
	}
	return true
}