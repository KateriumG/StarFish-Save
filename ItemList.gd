extends ItemList

# Called when the node enters the scene tree for the first time.
func _ready():
	position = $"..".Start_Position
	modulate.a = 0

func shade_in(my_name):
	if my_name == name:
		position = lerp(position, $"..".Central_Position, 0.05)
		#modulate.a = lerp(modulate.a, 100.0, 0.05)
		modulate.a = move_toward(modulate.a, 1, 0.05)
		
		if Vector2(0, modulate.a).distance_to(Vector2(0, 1)) < 5 and position.distance_to($"..".Central_Position) < 5:
			position = $"..".Central_Position
			$"..".set_process(false)

func shade_out(my_name):
	if my_name == name:
		position = lerp(position, $"..".Final_Position, 0.05)
		#modulate.a = lerp(modulate.a, 0.0, 0.05)
		modulate.a = move_toward(modulate.a, 0.0, 0.225)
	
		if Vector2(0, modulate.a).distance_to(Vector2(0, 0)) < 2.5 and position.distance_to($"..".Final_Position) < 2.5:
			position = $"..".Start_Position
			

