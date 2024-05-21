extends Control

var Is_Pausable = true

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$"..".set_process(true)
	$"../Player".set_process(true)
	$"../Player".set_physics_process(true)
	$"../Parallax".set_process(true)
	GLOBALDATA.Paused = false
	z_index = 20

func _input(event):
	if event.is_action("Escape") and event.is_action_pressed("Escape"):
		if visible == false and Is_Pausable == true and $"../Player".is_physics_processing() and $"../Player".Game_Lost == false:
			show()
			$Buttons/Button_Pause.grab_focus()
			$"..".set_process(false)
			$"../Player".set_process(false)
			$"../Player".set_physics_process(false)
			$"../Parallax".set_process(false)
			GLOBALDATA.Paused = true
		else:
			hide()
			$"..".set_process(true)
			if $"../Player".Game_Lost == false:
				$"../Player".set_process(true)
				$"../Player".set_physics_process(true)
			$"../Parallax".set_process(true)
			GLOBALDATA.Paused = false

func _on_button_pause_pressed():
	$AudioStreamPlayer.play()
	hide()
	$"..".set_process(true)
	if $"../Player".Game_Lost == false:
		$"../Player".set_process(true)
		$"../Player".set_physics_process(true)
	$"../Parallax".set_process(true)
	GLOBALDATA.Paused = false
	
func _on_button_quit_pressed():
	get_tree().change_scene_to_file("res://start_screen.tscn")

func _on_player_close_screen():
	z_index = 10
