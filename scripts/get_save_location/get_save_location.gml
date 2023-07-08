#macro FINAL_BUILD false

function get_save_location(){
	if FINAL_BUILD {
		return program_directory + "datafiles/Levels/"
	}
	//DEV: YOU CAN CHANGE THIS TO MAKE IT AUTO SAVE INTO THE REPOSITORY
	return working_directory + "Levels/"
}