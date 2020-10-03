extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Courtain.play_animation("fade_out")
	$CameraController.set_target($Player)
