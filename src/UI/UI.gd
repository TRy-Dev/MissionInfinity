extends Control

onready var mag_ammo_label = $CanvasLayer/BottomRight/WeaponUI/HBoxContainer/mag
onready var weap_ammo_label = $CanvasLayer/BottomRight/WeaponUI/HBoxContainer/ammo
onready var player_health_bar = $CanvasLayer/TopLeft/TextureRect/PlayerHealthBar
onready var stamina_bar = $CanvasLayer/TopLeft/TextureRect/StaminaBar
onready var tutorial_container = $CanvasLayer/DebugTutorial

func _ready():
	tutorial_container.modulate.a = 0.0
	if not GameController.tutorial_hidden:
		$AnimationPlayer.play("show_tutorial")
	GameController.connect("tutorial_hidden", self, "_on_tutorial_hidden")

func _update_magazine_ammo(val):
	mag_ammo_label.text = str(val)

func _update_weapon_ammo(val):
#	weap_ammo_label.text = str(val)
	pass

func _on_player_health_loss():
	pass

func _on_weapon_equipped(weapon):
	_update_magazine_ammo(weapon.magazine_ammo)
	_update_weapon_ammo(weapon.ammo)
	weapon.connect("reloaded", self, "_on_weapon_reloaded")
	weapon.connect("ammo_used", self, "_on_ammo_used")

func _on_ammo_used(magazine_ammo, amount):
	_update_magazine_ammo(magazine_ammo)
	
func _on_weapon_reloaded(ammo, magazine_ammo):
	_update_weapon_ammo(ammo)
	_update_magazine_ammo(magazine_ammo)

func _on_tutorial_hidden(val):
	if val:
		$AnimationPlayer.play("hide_tutorial")
	else:
		$AnimationPlayer.play("show_tutorial")




