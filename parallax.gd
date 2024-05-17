extends Node2D

var scroll_speed : Vector2 = Vector2.ZERO
var already_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().name == "Main_Game":
		if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right") and already_pressed == false:
			scroll_speed = Vector2(0, 1)
			already_pressed = true
		elif already_pressed == true:
			scroll_speed += Vector2(0, 0.0001)
		$ParallaxBackground.scroll_base_offset += scroll_speed
		if not $"../Player".is_physics_processing():
			$ParallaxBackground.scroll_base_offset.x = lerp(float($ParallaxBackground.scroll_base_offset.x), 0.1 , 0.05)
	else:
		scroll_speed = Vector2(0, 1)
		$ParallaxBackground.scroll_base_offset += scroll_speed
