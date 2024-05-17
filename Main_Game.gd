extends Node2D

@export var Items : PackedScene

var TPoints = 0
var Past_TPoints = 0
var Past_Best_Score = 0
var Past_Best_Stars = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI.set_points($Player.GPoints)

func _on_spawn_timer_timeout():
	if $Player.is_physics_processing():
		var Fall_Item = Items.instantiate()
		add_child(Fall_Item)
		var Fall_Item2 = Items.instantiate()
		add_child(Fall_Item2)
		#var Fall_Item3 = Items.instantiate()
		#add_child(Fall_Item3)

func _on_ui_restart_game():
	get_tree().reload_current_scene()

func _on_ui_animation_finish_end():
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
