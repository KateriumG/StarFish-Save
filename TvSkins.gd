extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	position = $"..".TV_Hide_Position
	print(position)


func Go_In():
	position = lerp(position, $"..".TV_Show_Position, 0.05)

func GO_Out():
	position = lerp(position, $"..".TV_Hide_Position, 0.05)
