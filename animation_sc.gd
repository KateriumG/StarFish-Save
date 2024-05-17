extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Normal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $A1.frame < 48:
		$A1.show()
		$A2.hide()
		$A3.hide()
	elif $A2.frame < 48:
		$A1.hide()
		$A2.show()
		$A3.hide()
	elif $A3.frame < 22:
		$A1.hide()
		$A2.hide()
		$A3.show()
