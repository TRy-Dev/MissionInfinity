extends Node2D

class_name Weapon

onready var cooldown_timer = $Cooldown
onready var bullet_pos = $BulletPos
onready var anim_player :AnimationPlayer = $AnimationPlayer
onready var sprite = $Sprite

export(int, 0, 40) var pivot_length = 20
export var cooldown = 0.2
export(PackedScene) var bullet_prefab

var start_bullet_pos_y

func _ready():
	cooldown_timer.wait_time = cooldown
	start_bullet_pos_y = bullet_pos.position.y

func flip(val: bool) -> void:
	sprite.flip_v = val
	if val:
		bullet_pos.position.y = -1 * start_bullet_pos_y
	else:
		bullet_pos.position.y = start_bullet_pos_y

func shoot() -> void:
	print("HEY! Implement weapon shooting: %s" %name)
