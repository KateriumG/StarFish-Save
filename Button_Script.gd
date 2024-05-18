extends Button

var Normal_Size : Vector2
var Focus_Size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	Normal_Size = scale
	Focus_Size = scale * 1.28

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_focus() and disabled == false:
		scale = lerp(scale, Focus_Size, 0.05)
	else:
		scale = lerp(scale, Normal_Size, 0.05)

func Hat_Is_Used(num):
	if name.contains("Hat"):
		if name != "No_Hat":
			if GLOBALDATA.Hats[num] == 2:
				modulate.a = 2
			else:
				modulate.a = 1
			
			if GLOBALDATA.Hats[num] == 0.1:
				disabled = true
			else:
				disabled = false
		else:
			if GLOBALDATA.Hats.has(2) == false:
				modulate.a = 2
			else:
				modulate.a = 1
