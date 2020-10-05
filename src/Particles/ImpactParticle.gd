extends Node2D

onready var anim_player = $AnimationPlayer

func init(pos) -> void:
	global_position = pos

func _ready():
	anim_player.play("play")
	yield(anim_player, "animation_finished")
	queue_free()
