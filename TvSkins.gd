extends Sprite2D

var Is_Right = false

var Main_Skin_Frame = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	position = $"..".TV_Hide_Position
	Show_Side_As(31)

func _process(delta):
	if GLOBALDATA.Antennae_Using == true:
		$Sprite2D.show()
		$Sprite2D_No_Ant.hide()
	else:
		$Sprite2D.hide()
		$Sprite2D_No_Ant.show()
	
	if GLOBALDATA.Hats.has(2):
		var Hat_Index = GLOBALDATA.Hats.find(2)
		match Hat_Index:
			0:
				Main_Skin_Frame.x = 0
			1:
				Main_Skin_Frame.x = 4
			2:
				Main_Skin_Frame.x = 8
			3:
				Main_Skin_Frame.x = 10
			4:
				Main_Skin_Frame.x = 12
			5:
				Main_Skin_Frame.x = 14
			6:
				Main_Skin_Frame.x = 18
			7:
				Main_Skin_Frame.x = 20
			8:
				Main_Skin_Frame.x = 22
			9:
				Main_Skin_Frame.x = 34
			10:
				Main_Skin_Frame.x = 36
			11: 
				Main_Skin_Frame.x = 38
		$Hats.show()
	else:
		$Hats.hide()
	
	if GLOBALDATA.FaceI.has(2):
		var FaceI_Index = GLOBALDATA.FaceI.find(2)
		match FaceI_Index:
			0:
				Main_Skin_Frame.y = 2
			1:
				Main_Skin_Frame.y = 6
			2:
				Main_Skin_Frame.y = 16
			3:
				Main_Skin_Frame.y = 24
			4:
				Main_Skin_Frame.y = 26
			5:
				Main_Skin_Frame.y = 28
			6:
				Main_Skin_Frame.y = 30
			7:
				Main_Skin_Frame.y = 32
			8:
				Main_Skin_Frame.y = 40
			9:
				Main_Skin_Frame.y = 42
		$FaceI.show() 
	else:
		$FaceI.hide()

func Go_In():
	position = lerp(position, $"..".TV_Show_Position, 0.05)

func GO_Out():
	position = lerp(position, $"..".TV_Hide_Position, 0.05)

func _on_tv_timer_timeout():
	Is_Right = not Is_Right == true
	if Is_Right == true:
		Show_Side_As(32)
		Set_Skin_Direction(Main_Skin_Frame + Vector2(1, 1))
	else:
		Show_Side_As(31)
		Set_Skin_Direction(Main_Skin_Frame)


func Show_Side_As(num):
	$Sprite2D.frame = num
	$Sprite2D_No_Ant.frame = num

func Set_Skin_Direction(direct):
	$Hats.frame = direct.x
	$FaceI.frame = direct.y

func Change_Image():
	Set_Skin_Direction(Main_Skin_Frame)

