#macro FINAL_BUILD false

function get_save_location(){
	if FINAL_BUILD {
		return program_directory + "datafiles/Levels/"
	}
	//DEV: YOU CAN CHANGE THIS TO MAKE IT AUTO SAVE INTO THE REPOSITORY
	return "C:/Users/dizzy/Documents/GameMakerStudio2/gmtk2023/datafiles/Levels/"
}