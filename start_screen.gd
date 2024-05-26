extends Node2D

var Start_Position = Vector2(380.0 , 190.0)
var Central_Position = Vector2(160.0, 190.0)
var Final_Position = Vector2(3.0, 190.0)

var TV_Show_Position = Vector2(873, 343)
var TV_Hide_Position = Vector2(873, 1087)

var Context = [1, "ItemList", 1, null]

var var_ = 0

func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	$ItemList.show()
	$ItemList2.show()
	$ItemList3.show()
	$ItemList4.show()
	$ItemList5.show()
	$ItemList6.show()
	$ItemList7.show()
	$ItemList8.show()
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
				Antennae_Update()
				$ItemList3.shade_in(Context[1])
				$ItemList3/Ant.grab_focus()
				$TvSkins.Go_In()
				$Animation_SC.Change_Size(Vector2(0.5, 0.5))
			"ItemList4":
				$ItemList4.shade_in(Context[1])
				$ItemList4/Button_Sound.grab_focus()
			"ItemList5":
				$ItemList5.shade_in(Context[1])
				$ItemList5/No_Hat.grab_focus()
				Check_Hats_On()
			"ItemList6":
				$ItemList6.shade_in(Context[1])
				$ItemList6/No_FaceI.grab_focus()
				Check_FaceI_On()
			"ItemList7":
				$ItemList7.shade_in(Context[1])
				$ItemList7/Button_Return7.grab_focus()
			"ItemList8":
				$ItemList8.shade_in(Context[1])
				$ItemList8/Master_Panel/Volume_Slider.grab_focus()
		
	if Context[3] != null:
		match Context[3]:
			"ItemList":
				$ItemList.shade_out(Context[3])
			"ItemList2":
				$ItemList2.shade_out(Context[3])
			"ItemList3":
				$ItemList3.shade_out(Context[3])
				if Context[1] == "ItemList2":
					$TvSkins.GO_Out()
					$Animation_SC.Change_Size(Vector2(3, 3))
			"ItemList4":
				$ItemList4.shade_out(Context[3])
			"ItemList5":
				$ItemList5.shade_out(Context[3])
			"ItemList6":
				$ItemList6.shade_out(Context[3])
			"ItemList7":
				$ItemList7.shade_out(Context[3])
			"ItemList8":
				$ItemList8.shade_out(Context[3])


func _on_button_quit_pressed():
	$AudioStreamPlayer2.play()
	get_tree().quit()

func _on_button_continue_pressed():
	Context = [1, "ItemList2", 1, "ItemList"]
	$ItemList2.position = Start_Position
	$ItemList2.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()
	
func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://main_game.tscn")

func _on_button_return_pressed():
	Context = [1, "ItemList", 1, "ItemList2"]
	$ItemList.position = Start_Position
	$ItemList.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()

func _on_button_return_2_pressed():
	Context = [1, "ItemList2", 1, "ItemList3"]
	$ItemList2.position = Start_Position
	$ItemList2.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()

func _on_button_store_pressed():
	Context = [1, "ItemList3", 1, "ItemList2"]
	$ItemList3.position = Start_Position
	$ItemList3.modulate.a = 0
	set_process(true)
	$ItemList3/TotalIcon/PointsIcon/Label.text = str(GLOBALDATA.TotalStars)
	$AudioStreamPlayer2.play()

func _on_button_return_3_pressed():
	Context = [1, "ItemList", 1, "ItemList4"]
	$ItemList.position = Start_Position
	$ItemList.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()

func _on_button_settings_pressed():
	Context = [1, "ItemList4", 1, "ItemList"]
	$ItemList4.position = Start_Position
	$ItemList4.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()

func _on_button_reset_pressed():
	GLOBALDATA.Best_Score = 0
	GLOBALDATA.Best_Stars = 0
	GLOBALDATA.TotalStars = 0
	GLOBALDATA.Hats = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 ]
	GLOBALDATA.FaceI = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1]
	GLOBALDATA.save()
	$AudioStreamPlayer2.play()

func _on_ant_pressed():
	GLOBALDATA.Antennae_Using = true
	if GLOBALDATA.Hats.has(2):
		var repeated = GLOBALDATA.Hats.find(2)
		GLOBALDATA.Hats[repeated] = 1
	GLOBALDATA.save()
	Antennae_Update()
	$AudioStreamPlayer2.play()
	
func _on_no_ant_pressed():
	GLOBALDATA.Antennae_Using = false
	GLOBALDATA.save()
	Antennae_Update()
	$AudioStreamPlayer2.play()

func _on_buy_box_pressed():
	if GLOBALDATA.TotalStars >= 35:
		GLOBALDATA.TotalStars -= 35
		$ItemList3/TotalIcon/PointsIcon/Label.text = str(GLOBALDATA.TotalStars)
		GLOBALDATA.save()
		$Unboxing_Sistem.show()
		$ItemList3/Buy_Box.release_focus()
		$AudioStreamPlayer2.play()

func _on_unboxing_sistem_hidden():
	if Context[1] == "ItemList3":
		$ItemList3/Ant.grab_focus()

func _on_button_skins_pressed():
	Context = [1, "ItemList5", 1, "ItemList3"]
	$ItemList5.position = Start_Position
	$ItemList5.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()

func _on_button_return_4_pressed():
	Context = [1, "ItemList3", 1, "ItemList5"]
	$ItemList4.position = Start_Position
	$ItemList4.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()

func Check_Hats_On():
	$ItemList5/No_Hat.Hat_Is_Used(0)
	$ItemList5/Hat0.Hat_Is_Used(0)
	$ItemList5/Hat1.Hat_Is_Used(1)
	$ItemList5/Hat2.Hat_Is_Used(2)
	$ItemList5/Hat3.Hat_Is_Used(3)
	$ItemList5/Hat4.Hat_Is_Used(4)
	$ItemList5/Hat5.Hat_Is_Used(5)
	$ItemList5/Hat6.Hat_Is_Used(6)
	$ItemList5/Hat7.Hat_Is_Used(7)
	$ItemList5/Hat8.Hat_Is_Used(8)
	$ItemList5/Hat9.Hat_Is_Used(9)
	$ItemList5/Hat10.Hat_Is_Used(10)
	$ItemList5/Hat11.Hat_Is_Used(11)

func Antennae_Update():
	if GLOBALDATA.Antennae_Using == true:
		$ItemList3/Ant.modulate.a = 2
		$ItemList3/No_Ant.modulate.a = 1
	else:
		$ItemList3/No_Ant.modulate.a = 2
		$ItemList3/Ant.modulate.a = 1

func _on_hat_0_pressed():
	Get_Hat(0)

func _on_hat_1_pressed():
	Get_Hat(1)

func _on_hat_2_pressed():
	Get_Hat(2)

func _on_hat_3_pressed():
	Get_Hat(3)

func _on_hat_4_pressed():
	Get_Hat(4)

func _on_no_hat_pressed():
	if GLOBALDATA.Hats.has(2):
		var repeated = GLOBALDATA.Hats.find(2)
		GLOBALDATA.Hats[repeated] = 1
	GLOBALDATA.save()
	Check_Hats_On()
	$AudioStreamPlayer2.play()

func _on_hat_5_pressed():
	Get_Hat(5)

func _on_hat_6_pressed():
	Get_Hat(6)

func _on_hat_7_pressed():
	Get_Hat(7)

func _on_hat_8_pressed():
	Get_Hat(8)

func _on_hat_9_pressed():
	Get_Hat(9)

func _on_hat_10_pressed():
	Get_Hat(10)

func _on_hat_11_pressed():
	Get_Hat(11)

func Get_Hat(Hat):
	if GLOBALDATA.Hats.has(2):
		var repeated = GLOBALDATA.Hats.find(2)
		GLOBALDATA.Hats[repeated] = 1
	GLOBALDATA.Hats[Hat] = 2
	GLOBALDATA.Antennae_Using = false
	GLOBALDATA.save()
	Check_Hats_On()
	$AudioStreamPlayer2.play()

func _on_button_continue_2_pressed():
	Context = [1, "ItemList6", 1, "ItemList5"]
	$ItemList6.position = Start_Position
	$ItemList6.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()

func _on_button_return_5_pressed():
	Context = [1, "ItemList5", 1, "ItemList6"]
	$ItemList5.position = Start_Position
	$ItemList5.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()

func _on_button_exit_pressed():
	Context = [1, "ItemList3", 1, "ItemList6"]
	$ItemList3.position = Start_Position
	$ItemList3.modulate.a = 0
	set_process(true)
	$ItemList3/TotalIcon/PointsIcon/Label.text = str(GLOBALDATA.TotalStars)
	$AudioStreamPlayer2.play()

func Check_FaceI_On():
	$ItemList6/No_FaceI.FaceI_Is_Used(0)
	$ItemList6/FaceI0.FaceI_Is_Used(0)
	$ItemList6/FaceI1.FaceI_Is_Used(1)
	$ItemList6/FaceI2.FaceI_Is_Used(2)
	$ItemList6/FaceI3.FaceI_Is_Used(3)
	$ItemList6/FaceI4.FaceI_Is_Used(4)
	$ItemList6/FaceI5.FaceI_Is_Used(5)
	$ItemList6/FaceI6.FaceI_Is_Used(6)
	$ItemList6/FaceI7.FaceI_Is_Used(7)
	$ItemList6/FaceI8.FaceI_Is_Used(8)
	$ItemList6/FaceI9.FaceI_Is_Used(9)
	
func Get_FaceI(FaceI):
	if GLOBALDATA.FaceI.has(2):
		var repeated = GLOBALDATA.FaceI.find(2)
		GLOBALDATA.FaceI[repeated] = 1
	GLOBALDATA.FaceI[FaceI] = 2
	GLOBALDATA.save()
	Check_FaceI_On()
	$AudioStreamPlayer2.play()

func _on_no_face_i_pressed():
	if GLOBALDATA.FaceI.has(2):
		var repeated = GLOBALDATA.FaceI.find(2)
		GLOBALDATA.FaceI[repeated] = 1
	GLOBALDATA.save()
	Check_FaceI_On()
	$AudioStreamPlayer2.play()

func _on_face_i_0_pressed():
	Get_FaceI(0)

func _on_face_i_1_pressed():
	Get_FaceI(1)

func _on_face_i_2_pressed():
	Get_FaceI(2)

func _on_face_i_3_pressed():
	Get_FaceI(3)

func _on_face_i_4_pressed():
	Get_FaceI(4)

func _on_face_i_5_pressed():
	Get_FaceI(5)

func _on_face_i_6_pressed():
	Get_FaceI(6)

func _on_face_i_7_pressed():
	Get_FaceI(7)

func _on_face_i_8_pressed():
	Get_FaceI(8)

func _on_face_i_9_pressed():
	Get_FaceI(9)

func _on_button_credits_pressed():
	Context = [1, "ItemList7", 1, "ItemList"]
	$ItemList7.position = Start_Position
	$ItemList7.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()

func _on_button_return_7_pressed():
	Context = [1, "ItemList", 1, "ItemList7"]
	$ItemList.position = Start_Position
	$ItemList.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()

func _on_button_sound_pressed():
	Context = [1, "ItemList8", 1, "ItemList4"]
	$ItemList8.position = Start_Position
	$ItemList8.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()

func _on_button_return_8_pressed():
	Context = [1, "ItemList4", 1, "ItemList8"]
	$ItemList4.position = Start_Position
	$ItemList4.modulate.a = 0
	set_process(true)
	$AudioStreamPlayer2.play()

