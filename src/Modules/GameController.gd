extends Node

var main_menu_scene = preload("res://src/UI/MainMenu.tscn")

var battle_index = 0
var battles = [
	preload("res://src/Battle.tscn")
]

func _ready():
	Courtain.play_animation("fade_out")
	MusicController.set_volume_db(0)
	MusicController.play_animation("fade_in")

func _process(delta):
	if Input.is_action_just_pressed("debug_restart"):
		load_scene(main_menu_scene)

func load_scene(scene):
	if scene:
		Courtain.play_animation("fade_in")
		MusicController.play_animation("fade_out")
		yield(Courtain.anim_player, "animation_finished")
		get_tree().change_scene_to(scene)
		Courtain.play_animation("fade_out")
		MusicController.play_animation("fade_in")

func load_menu():
	load_scene(main_menu_scene)

func mission_finished():
	SfxController.play("mission-won")
	Weapons.unlock_next_weapon()
	GameDialogue.next_dialogue()
	load_menu()

func load_next_battle():
	load_scene(battles[battle_index])
	battle_index = (battle_index + 1) % len(battles)
	
