extends Control

signal Animation_Finish_End
signal Restart_game

var display_points = Vector3(0, 0, 0)

var game_is_finished_1 = false
var game_is_finished_2 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$End_UI.hide()
	$Keys_UI.show()
	if Input.get_joy_name(0) == "":
		$Keys_UI/AnimationPlayer.play("Key")
	else:
		$Keys_UI/AnimationPlayer.play("Gamepad")

func _process(delta):
	if game_is_finished_1 == true:
		$End_UI/Points3.text = str(display_points.x)
		$End_UI/Points_Time3.text = str(display_points.y)
		display_points.x = move_toward(display_points.x, GLOBALDATA.Best_Stars, 1)
		display_points.y = move_toward(display_points.y, GLOBALDATA.Best_Score, 1)
		$AudioStreamPlayer2.play()
	
		if display_points.x == GLOBALDATA.Best_Stars and display_points.y == GLOBALDATA.Best_Score:
			game_is_finished_1 = false
			$End_UI/Points3.text = str(GLOBALDATA.Best_Stars)
			$End_UI/Points_Time3.text = str(GLOBALDATA.Best_Score)
	
	if game_is_finished_2 == true:
		$End_UI/Points4.text = str(display_points.z)
		display_points.z = move_toward(display_points.z, GLOBALDATA.TotalStars, 1)
	
		if display_points.z == GLOBALDATA.TotalStars:
			game_is_finished_2 = false
			$End_UI/Points4.text = str(GLOBALDATA.TotalStars)
	
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		$Keys_UI.hide()

func set_time_points(points):
	$Points_Time.text = str(points)

func set_points(points):
	$Points.text = str(points)
	

func _on_end_animation_animation_finished():
	emit_signal("Animation_Finish_End")
	$End_UI.show()
	$End_UI/Button_Restart.grab_focus()
	$End_UI/Points2.text = $Points.text
	$End_UI/Points_Time2.text = $Points_Time.text
	#$End_UI/Points3.text = str(GLOBALDATA.Best_Stars)
	#$End_UI/Points_Time3.text = str(GLOBALDATA.Best_Score)

func animation_change_points(past_st, past_sc, past_t_st):
	if display_points.x < GLOBALDATA.Best_Stars and display_points.y < GLOBALDATA.Best_Score:
		display_points.x = past_st
		display_points.y = past_sc
		$End_UI/Points3.text = str(display_points.x)
		$End_UI/Points_Time3.text = str(display_points.y)
		game_is_finished_1 = true
	else:
		$End_UI/Points3.text = str(GLOBALDATA.Best_Stars)
		$End_UI/Points_Time3.text = str(GLOBALDATA.Best_Score)

	display_points.z = past_t_st
	$End_UI/Points4.text = str(display_points.z)
	game_is_finished_2 = true

func _on_player_close_screen():
	$End_Animation.play("close_screen")

func _on_button_restart_pressed():
	$AudioStreamPlayer.play()
	emit_signal("Restart_game")
	$End_UI.hide()

func _on_button_exit_pressed():
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://start_screen.tscn")

func _input(event):
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		$Keys_UI.hide()
