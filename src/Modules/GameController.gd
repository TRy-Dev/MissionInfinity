extends Node

var restart_scene = preload("res://src/UI/MainMenu.tscn")

func _ready():
	Courtain.play_animation("fade_out")

func _process(delta):
	if Input.is_action_just_pressed("debug_restart"):
		load_scene(restart_scene)

func load_scene(scene):
	if scene:
		Courtain.play_animation("fade_in")
		yield(Courtain.anim_player, "animation_finished")
		get_tree().change_scene_to(scene)
		Courtain.play_animation("fade_out")
