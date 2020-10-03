extends Node2D


func _ready():
	Courtain.play_animation("fade_out")
	$CameraController.set_target($Player)
	MusicController.play("blueprint")

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
