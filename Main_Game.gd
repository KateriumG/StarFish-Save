extends Node2D

@export var Items : PackedScene

var TPoints = 0
var Past_TPoints = 0
var Past_Best_Score = 0
var Past_Best_Stars = 0
var Difficulty = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Android" or OS.get_name() == "i0S":
		$Button_Pause.show()
		$Button_Pause.disabled = false
	else:
		$Button_Pause.hide()
		$Button_Pause.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI.set_points($Player.GPoints)

func _on_spawn_timer_timeout():
	if $Player.is_physics_processing():
		if Difficulty == 1 or Difficulty > 1:
			var Fall_Item = Items.instantiate()
			add_child(Fall_Item)
			if Difficulty == 2 or Difficulty > 2:
				var Fall_Item2 = Items.instantiate()
				add_child(Fall_Item2)
				if Difficulty == 3:
					var Fall_Item3 = Items.instantiate()
					add_child(Fall_Item3)

func _on_ui_restart_game():
	get_tree().reload_current_scene()

func _on_ui_animation_finish_end():
	$Pause_Menu.Is_Pausable = false
	# Sets both Past and New Total Stars for each other
	Past_TPoints = GLOBALDATA.TotalStars
	GLOBALDATA.TotalStars += $Player.GPoints
	# Sets both Past and New Bests
	if $Player.GPoints > GLOBALDATA.Best_Stars:
		Past_Best_Stars = GLOBALDATA.Best_Stars
		GLOBALDATA.Best_Stars = $Player.GPoints
	if TPoints > GLOBALDATA.Best_Score:
		Past_Best_Score = GLOBALDATA.Best_Score
		GLOBALDATA.Best_Score = TPoints
		
	$UI.animation_change_points(Past_Best_Stars, Past_Best_Score, Past_TPoints)
	
	GLOBALDATA.save()

func _on_points_timer_timeout():
	if $Player.is_physics_processing():
		TPoints += 1
		$UI.set_time_points(TPoints)
		if TPoints > 110:
			Difficulty = 2
		if TPoints > 440:
			Difficulty = 3

func _on_button_pause_pressed():
	$Pause_Menu.Pause_The_Game()
