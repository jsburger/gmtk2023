function Procedure(run, draw) constructor {
	progress = 0;
	done = false;
	self.run = run;
	self.draw = draw;
	
	static reset = function() {
		progress = 0;
		done = false;
	}
}
function ProcedureRunner() constructor {
	procedures = [];
	current_procedure = 0;
	done = false;
	//Unused
	progress = 0;
	/// @param {Struct.Procedure} procedure
	static add = function(procedure) {
		array_push(procedures, procedure)
	}
	
	static run = function() {
		if done return true;
		var proc = procedures[current_procedure];
		proc.run(proc.progress, proc);
		if proc.done {
			if current_procedure >= (array_length(procedures) - 1) {
				done = true;
			}
			else {
				current_procedure += 1;
			}
			return true;
		}
		else {
			proc.progress += 1;
		}
		return false;
	}
	
	static draw = function() {
		if (procedures[current_procedure].progress == 0 && current_procedure > 0) {
			procedures[current_procedure - 1].draw();
		}
		else {
			procedures[current_procedure].draw();
		}
	}
	
	static reset = function() {
		current_procedure = 0;
		progress = 0;
		done = false;
		for (var i = 0; i < array_length(procedures); i++) {
			procedures[i].reset();
		}
	}
}