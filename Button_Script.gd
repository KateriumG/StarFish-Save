extends Button

var Normal_Size : Vector2
var Focus_Size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	Normal_Size = scale
	Focus_Size = scale * 1.28

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_focus():
		scale = lerp(scale, Focus_Size, 0.05)
	else:
		scale = lerp(scale, Normal_Size, 0.05)
