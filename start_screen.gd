extends Node2D

var Start_Position = Vector2(380.0 , 190.0)
var Central_Position = Vector2(160.0, 190.0)
var Final_Position = Vector2(3.0, 190.0)

var Context = [1, "ItemList", 1, null]

var var_ = 0

func _ready():
	$ItemList.show()
	$ItemList2.show()
	$ItemList3.show()
	#$AnimatedSprite2D.play("Main_Loop")
	set_process(true)

func _process(delta):
	if Context[0] == 1:
		match Context[1]:
			"ItemList":
				$ItemList.shade_in(Context[1])
				$ItemList/Button_Continue.grab_focus()
			"ItemList2":
				$ItemList2.shade_in(Context[1])
				$ItemList2/Button_Play.grab_focus()
			"ItemList3":
				$ItemList3.shade_in(Context[1])
				$ItemList3/Ant.grab_focus()
			"ItemList4":
				$ItemList4.shade_in(Context[1])
				$ItemList4/Button_Button.grab_focus()
		
	if Context[3] != null:
		match Context[3]:
			"ItemList":
				$ItemList.shade_out(Context[3])
			"ItemList2":
				$ItemList2.shade_out(Context[3])
			"ItemList3":
				$ItemList3.shade_out(Context[3])
			"ItemList4":
				$ItemList4.shade_out(Context[3])


func _on_button_quit_pressed():
	get_tree().quit()

func _on_button_continue_pressed():
	Context = [1, "ItemList2", 1, "ItemList"]
	$ItemList2.position = Start_Position
	$ItemList2.modulate.a = 0
	set_process(true)
	

func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://main_game.tscn")

func _on_button_return_pressed():
	Context = [1, "ItemList", 1, "ItemList2"]
	$ItemList.position = Start_Position
	$ItemList.modulate.a = 0
	set_process(true)

func _on_button_return_2_pressed():
	Context = [1, "ItemList2", 1, "ItemList3"]
	$ItemList2.position = Start_Position
	$ItemList2.modulate.a = 0
	set_process(true)

func _on_button_store_pressed():
	Context = [1, "ItemList3", 1, "ItemList2"]
	$ItemList3.position = Start_Position
	$ItemList3.modulate.a = 0
	set_process(true)
	$ItemList3/TotalIcon/PointsIcon/Label.text = str(GLOBALDATA.TotalStars)


func _on_button_return_3_pressed():
	Context = [1, "ItemList", 1, "ItemList4"]
	$ItemList.position = Start_Position
	$ItemList.modulate.a = 0
	set_process(true)

func _on_button_settings_pressed():
	Context = [1, "ItemList4", 1, "ItemList"]
	$ItemList4.position = Start_Position
	$ItemList4.modulate.a = 0
	set_process(true)

func _on_button_reset_pressed():
	GLOBALDATA.Best_Score = 0
	GLOBALDATA.Best_Stars = 0
	GLOBALDATA.TotalStars = 0
	GLOBALDATA.Hats = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 ]
	GLOBALDATA.FaceI = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1]
	GLOBALDATA.save()

func _on_ant_pressed():
	GLOBALDATA.Antennae_Using = true
	GLOBALDATA.save()
	
func _on_no_ant_pressed():
	GLOBALDATA.Antennae_Using = false
	GLOBALDATA.save()

func _on_buy_box_pressed():
	if GLOBALDATA.TotalStars >= 35:
		GLOBALDATA.TotalStars -= 35
		$ItemList3/TotalIcon/PointsIcon/Label.text = str(GLOBALDATA.TotalStars)
		GLOBALDATA.save()
		$Unboxing_Sistem.show()

func _on_unboxing_sistem_hidden():
	if Context[1] == "ItemList3":
		$ItemList3/Ant.grab_focus()
