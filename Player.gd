extends CharacterBody2D


signal Close_Screen

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var directional : int

var Center = Vector2(576, 324)

var Game_Lost = false
var anim_GO_Finished = false
var anim_rot = false

var speed_move_x = 0
var speed_move_y = 0
var speed_rotation_death = 0
var rotated_times = 0
var GPoints = 0


func _ready():
	rotation_degrees = 0
	set_physics_process(false)
	
	if GLOBALDATA.Antennae_Using == true:
		$Sprite2D.show()
		$Sprite2D_No_Ant.hide()
	else:
		$Sprite2D_No_Ant.show()
		$Sprite2D.hide()
	
	$AnimationPlayer.play("Idle")

func _process(delta):
	if not is_physics_processing() and Game_Lost == false:
		if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
			set_physics_process(true)
			$AnimationPlayer.play("Jump")
	elif Game_Lost == true:
		$AnimationPlayer.play("Failed")

		if anim_GO_Finished == false:
			Game_Over()
		else:
			Failed_Anim()

func _physics_process(delta):
	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		velocity.y = JUMP_VELOCITY
		$AnimationPlayer.play("Jump")
		$AnimationPlayer.queue("Fall")

	# Get the input direction
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		directional = direction
		$Sprite2D.flip_h = not direction == 1
		
		# Get the rotation and Game Over conditions
	if directional > 0:
		rotation_degrees = (velocity.y / 15 * directional) + 90
	elif directional < 0:
		rotation_degrees = (velocity.y / 15 * directional) - 90
	
	if position.y > 658 or position.y < -10 or position.x > 1162 or position.x < -10:
		Game_Lost = true 
		set_physics_process(false)
	
	move_and_slide()

func Game_Over():
	position = lerp(position, Center, 0.05)
	rotation_degrees = lerp(rotation_degrees, 0.1, 0.05)
	
	if position.distance_to(Center) < 5 and Vector2(rotation_degrees, 0).distance_to(Vector2(0.1, 0)) < 5: 
		anim_GO_Finished = true

func Failed_Anim():
	if anim_rot == false:
		rotation_degrees = move_toward(rotation_degrees, 45, 4)
		anim_rot = round(rotation_degrees) == 45
	else:
		rotation_degrees = move_toward(rotation_degrees, -45, 4)
		anim_rot = not round(rotation_degrees) == -45
		rotated_times += 1
		
	if rotated_times > 15:
		emit_signal("Close_Screen")

func Touched_Other_Item(type_item):
	match type_item:
		1:
			GPoints += 1
		2:
			Game_Lost = true
			set_physics_process(false)
		3:
			Game_Lost = true
			set_physics_process(false)

func _on_ui_animation_finish_end():
	set_process(false)


