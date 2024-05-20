extends HSlider

@export var bus_name : String

var bus_index : int

# Called when the node enters the scene tree for the first time.
func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	match bus_name:
		"Master":
			AudioServer.set_bus_volume_db(bus_index, linear_to_db(GLOBALDATA.SoundsData.x))
		"Music":
			AudioServer.set_bus_volume_db(bus_index, linear_to_db(GLOBALDATA.SoundsData.y))
		"SFX":
			AudioServer.set_bus_volume_db(bus_index, linear_to_db(GLOBALDATA.SoundsData.z))
	
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	
func _on_value_changed(value):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	match bus_name:
		"Master":
			GLOBALDATA.SoundsData.x = value
		"Music":
			GLOBALDATA.SoundsData.y = value
		"SFX":
			GLOBALDATA.SoundsData.z = value
	GLOBALDATA.save()
