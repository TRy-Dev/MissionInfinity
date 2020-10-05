extends Control

onready var cursor = $Cursor
onready var story_text = $Story/Text/RichTextLabel
onready var cursor_anim = $Cursor/AnimationPlayer
onready var map_anim = $Map/AnimationPlayer
onready var text_anim = $Story/Text/AnimationPlayer

var battle_scene = preload("res://src/Main.tscn")

const TEXT_REVEAL_SPEED = 100.0

func _ready():
	MusicController.play("menu")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	map_anim.play("pulse")
	cursor_anim.play("idle")
	text_anim.playback_speed = TEXT_REVEAL_SPEED / len(story_text.text)
	text_anim.play("show_text")

	for planet in $Map/Plain/Planets.get_children():
		planet.connect("mouse_entered", self, "_on_mouse_entered_planet")
		planet.connect("mouse_exited", self, "_on_mouse_exited_planet")
		planet.modulate.a = 0.5

func _process(delta):
	cursor.global_position = get_global_mouse_position()
#	if Input.is_action_just_pressed("shoot"):
#		cursor_anim.play("point")
#	elif Input.is_action_just_released("shoot"):
#		cursor_anim.play("idle")

func _on_mouse_entered_planet():
	cursor_anim.play("point")

func _on_mouse_exited_planet():
	cursor_anim.play("idle")

func start_game():
	GameController.load_scene(battle_scene)
