extends Control

onready var cursor = $Cursor
onready var story_text = $Story/Text/RichTextLabel
onready var cursor_anim = $Cursor/AnimationPlayer
onready var map_anim = $Right/Map/AnimationPlayer
onready var text_anim = $Story/Text/AnimationPlayer
onready var weapon_dropdown = $Right/Weapons/HBoxContainer/VBoxContainer/WeaponDropdown
onready var weapons_container = $Right/Weapons

onready var text_type_timer = $Story/Text/TextTypeTimer
onready var text_type_sound = $Story/Text/TextTypeSound

onready var face_1 = $Story/Screen/Face1
onready var face_2 = $Story/Screen/Face2

#var battle_scene = preload("res://src/Main.tscn")

const TEXT_REVEAL_SPEED = 60.0

const CURSOR_OFFSET = Vector2(0, 5.0)

func _ready():
	MusicController.play("menu")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	face_1.visible = true
	face_2.visible = false

	story_text.text = GameDialogue.get_current_dialogue()
	map_anim.play("pulse")
	cursor_anim.play("idle")
	text_anim.playback_speed = TEXT_REVEAL_SPEED / len(story_text.text)
	text_anim.play("show_text")
	
	text_type_timer.wait_time = 1.0 / text_anim.playback_speed
	text_type_timer.start()
	text_type_sound.start()

	for planet in $Right/Map/Planets.get_children():
		planet.connect("mouse_entered", self, "_on_mouse_entered_planet")
		planet.connect("mouse_exited", self, "_on_mouse_exited_planet")
		planet.modulate.a = 0.5
		
	for weapon in Weapons.get_unlocked_weapons():
		weapon_dropdown.add_item(weapon)
	Weapons.set_start_weapon(0)
	
	if len(Weapons.get_unlocked_weapons()) > 1:
		weapons_container.visible = true
	else:
		weapons_container.visible = false
	
	var buttons = $Right/Map/Planets.get_children()
	for i in range(len(buttons)):
		if i != GameController.battle_index:
			buttons[i].queue_free()


func _process(delta):
	cursor.global_position = get_global_mouse_position() + CURSOR_OFFSET

func _on_mouse_entered_planet():
	cursor_anim.play("point")

func _on_mouse_exited_planet():
	cursor_anim.play("idle")

func start_game():
	GameController.load_next_battle()

func _on_WeaponDropdown_item_selected(index):
	Weapons.set_start_weapon(index)


func _on_FaceToggleTimer_timeout():
	_toggle_screen_faces()
	
func _toggle_screen_faces():
	face_1.visible = not face_1.visible
	face_2.visible = not face_2.visible


func _on_TextTypeTimer_timeout():
	text_type_sound.stop()


func _on_TextTypeSound_timeout():
	SfxController.play("text-scroll-sound")
