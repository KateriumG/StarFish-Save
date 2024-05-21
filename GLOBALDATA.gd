extends Node

var Save_File = "user://MainFile.save"

#Saved_Variables
var TotalStars : int
var Best_Score : int
var Best_Stars : int
var Antennae_Using : bool 
var Hats : Array
var FaceI : Array
var SoundsData : Vector3

#Not Saved Variables
var Paused : bool = false

func _ready():
	load_files()

func save():
	var file = FileAccess.open(Save_File, FileAccess.WRITE)
	file.store_var(TotalStars)
	file.store_var(Best_Score)
	file.store_var(Best_Stars)
	file.store_var(Antennae_Using)
	file.store_var(Hats)
	file.store_var(FaceI)
	file.store_var(SoundsData)

func load_files():
	if FileAccess.file_exists(Save_File):
		var file = FileAccess.open(Save_File, FileAccess.READ)
		TotalStars = file.get_var()
		Best_Score = file.get_var()
		Best_Stars = file.get_var()
		Antennae_Using = file.get_var()
		Hats = file.get_var()
		FaceI = file.get_var()
		SoundsData = file.get_var()
	else:
		TotalStars = 0
		Best_Score = 0
		Best_Stars = 0
		Antennae_Using = true
		Hats = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 ]
		FaceI = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1]
		SoundsData = Vector3(0.5, 1, 1)
