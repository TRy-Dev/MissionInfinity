extends Control

onready var anim_player :AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	for effect in $CanvasLayer.get_children():
		effect.color.a = 0.0


func play_animation(name) -> void:
	if anim_player.has_animation(name):
		anim_player.play(name)
	else:
		print("HEY! Courtain has no such animation: %s" %name)
