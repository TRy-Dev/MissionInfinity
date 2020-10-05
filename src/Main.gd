extends Node2D

onready var camera_controller = $CameraController
onready var player = $World/YSort/Player
onready var ui = $UI

func _ready():
	Courtain.play_animation("fade_out")
	MusicController.play("blueprint")
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	camera_controller.set_target(player, false)
	camera_controller.set_zoom(0.7, false)
	camera_controller.set_zoom(0.5, true)
	
	player.weapon_controller.connect("weapon_equipped", ui, "_on_weapon_equipped")
	player.connect("actor_hurt", self, "_on_player_hurt")
	player.connect("actor_hurt", ui.player_health_bar, "_on_health_bar_updated")
	player.connect("stamina_updated", ui.stamina_bar, "_on_health_bar_updated")
	player.connect("actor_died", self, "_on_player_died")
	player.connect("actor_died", Courtain, "_on_player_died")
	ui.player_health_bar._on_max_health_updated(player.MAX_HEALTH)
	ui.stamina_bar._on_max_health_updated(player.MAX_STAMINA)
	player.late_ready()
	
	MusicController.set_volume_db(-10)
	

func _process(delta):
#	if Input.is_action_just_pressed("restart"):
#		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("mute_music"):
		MusicController.toggle_muted()
	if Input.is_action_just_pressed("mute_sfx"):
		pass

func _on_player_died():
	print("Player died - MAIN")


func _on_player_hurt(current_health, amount):
	var shake_amount = max(0.5, (100.0 - current_health) / 100.0)
	shake_amount += 1.0
	shake_amount *= amount / 100.0
	print(shake_amount)
	camera_controller.add_trauma(shake_amount)



