extends Area2D

var s_speed = 0
var f_speed = 0
var type_me = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	type_me = randi() % 3 + 1
	position.x = randi() % 1152 + 1
	# Sets the random Node's Speed
	if type_me != 3:
		s_speed = randi_range(80, 90)
		f_speed = randi_range(160, 180)
	else:
		f_speed = randi_range(240, 260)
	# Randomizes scale in each condition
	if type_me == 1:
		$Good_Collision.scale = Vector2(1.15, 1.15)
		$AnimatedSprite2D.scale = Vector2(1.35, 1.35)
		position.y = -55
	elif type_me == 2:
		#Randomizes size of Space Rock
		$AnimatedSprite2D.scale.x = randf_range(1.45, 2.1)
		$AnimatedSprite2D.scale.y = $AnimatedSprite2D.scale.x
		$Good_Collision.scale = $AnimatedSprite2D.scale / Vector2(2.13, 2.13)
		position.y = $AnimatedSprite2D.scale.x * -325
	else:
		$AnimatedSprite2D.scale.x = randf_range(1.2, 1.61)
		$AnimatedSprite2D.scale.y = $AnimatedSprite2D.scale.x
		$Good_Collision.scale = $AnimatedSprite2D.scale / Vector2(1.84, 1.84)
		position.y = $AnimatedSprite2D.scale.x * -325

	
	# Makes Meteorite special parameters
	if type_me == 3:
		if position.x < 576:
			rotation_degrees = randi_range(135, 180)
		else:
			rotation_degrees = randi_range(180, 225)
		$AnimatedSprite2D.offset.y = 75
		z_index = -5
	else:
		rotation_degrees = 0
		$AnimatedSprite2D.offset.y = 0
		z_index = 5
		
	Animation_Loop(type_me)

func _physics_process(delta):
	if GLOBALDATA.Paused == true:
		set_process(false)
		z_index = 0
		$AnimatedSprite2D.stop()
	else:
		set_process(true)
		z_index = 5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Animation_Loop(type_me)
	
	if type_me == 1 or type_me == 2:
		position.y += s_speed * delta
		if not s_speed == f_speed:
			s_speed = lerp(float(s_speed), float(f_speed), 0.5)
	else:
		position += Vector2(0, -f_speed * delta).rotated(deg_to_rad(rotation_degrees))
	
	if type_me != 3:
		if position.y > 712:
			queue_free()
	else:
		if position.y > 1100:
			queue_free()

func _on_body_entered(body):
	if body.has_method("Touched_Other_Item") and GLOBALDATA.Paused == false:
		if type_me != 3:
			set_physics_process(false)
			set_process(false)
			body.Touched_Other_Item(type_me)
			if type_me == 1:
				$AnimatedSprite2D.play("End_Star")
			else:
				$AnimatedSprite2D.play("End_Rock")
			await $AnimatedSprite2D.animation_finished
			queue_free()
		else:
			body.Touched_Other_Item(type_me)

func Animation_Loop(type):
	if type == 1:
		$AnimatedSprite2D.play("Normal_Star")
	elif type == 2:
		$AnimatedSprite2D.play("Normal_Rock")
	else:
		$AnimatedSprite2D.play("Normal_Meteorite")
