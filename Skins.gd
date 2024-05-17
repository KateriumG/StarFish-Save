extends Sprite2D

var start_growing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(0.05, 0.05)
	$Label.text = ""
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_growing == true:
		Select_Image()
		show()
		scale = lerp(scale, Vector2(4.0 ,4.0), 0.05)

func Select_Image():
	if $"..".is_a_hat == 0:
		match $"..".skin_received:
			0:
				frame = 0
			1:
				frame = 4
			2:
				frame = 8
			3:
				frame = 10
			4:
				frame = 12
			5:
				frame = 14
			6:
				frame = 18
			7:
				frame = 20
			8:
				frame = 22
			9:
				frame = 34
			10:
				frame = 36
			11:
				frame = 38
		offset.y = 30
	else:
		match $"..".skin_received:
			0:
				frame = 2
			1:
				frame = 6
			2:
				frame = 16
			3:
				frame = 24
			4:
				frame = 26
			5:
				frame = 28
			6:
				frame = 30
			7:
				frame = 32
			8:
				frame = 40
			9:
				frame = 42
		offset.y = 10
