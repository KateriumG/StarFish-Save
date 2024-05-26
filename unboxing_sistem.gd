extends Node2D

signal Reload_Skins

var already_pressed = false

var skin_received = 0
var is_a_hat = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$Buttons.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible == true:
		if Input.is_action_just_pressed("ui_accept") and already_pressed == false:
			Unlock_Item()
		elif Input.is_action_just_pressed("Click") and already_pressed == false:
			Unlock_Item()
	
		if $AnimationPlayer.current_animation == "Unlock":
			await $AnimationPlayer.animation_finished
			$Box.hide()
			$Skins.start_growing = true
			$Buttons.show()
			$Buttons/Use_Button.grab_focus()


func Unlock_Item():
	$AnimationPlayer.play("Unlock")
	already_pressed = true
	is_a_hat = randi_range(0, 1)
	
	if is_a_hat == 0:
		skin_received = randi() % 12
		
		if GLOBALDATA.Hats[skin_received] == 0.1:
			$Skins/Label.text = "New!"
		else:
			$Skins/Label.text = "Repeated"
	else:
		skin_received = randi() % 10
		
		if GLOBALDATA.FaceI[skin_received] == 0.1:
			$Skins/Label.text = "New!"
			$Skins/Label.position.x = -20
		else:
			$Skins/Label.text = "Repeated"
			$Skins/Label.position.x = -36

func _on_use_button_pressed():
	$AudioStreamPlayer.play()
	if is_a_hat == 0:
		if GLOBALDATA.Hats.has(2):
			var repeated = GLOBALDATA.Hats.find(2)
			GLOBALDATA.Hats[repeated] = 1
			
		GLOBALDATA.Hats[skin_received] = 2
	else:
		if GLOBALDATA.FaceI.has(2):
			var repeated = GLOBALDATA.FaceI.find(2)
			GLOBALDATA.FaceI[repeated] = 1
		
		GLOBALDATA.FaceI[skin_received] = 2
	$"../TvSkins".Change_Image()
	Reload_Cutscene()

func _on_leave_button_pressed():
	$AudioStreamPlayer.play()
	if is_a_hat == 0:
		GLOBALDATA.Hats[skin_received] = 1
	else:
		GLOBALDATA.FaceI[skin_received] = 1
			
	Reload_Cutscene()

func Reload_Cutscene():
	GLOBALDATA.save()
	hide()
	$Buttons.hide()
	already_pressed = false
	is_a_hat = 0
	skin_received = 0
	$Box.show()
	$AnimationPlayer.play("Idle")
	emit_signal("Reload_Skins")
	
