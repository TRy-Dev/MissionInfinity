extends Node2D

onready var cooldown_timer = $Cooldown
onready var bullet_pos = $BulletPos
onready var anim_player :AnimationPlayer = $AnimationPlayer
onready var sprite = $Sprite

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
	if cooldown_timer.is_stopped():
		cooldown_timer.start()
		var new_bullet = bullet_prefab.instance()
		new_bullet.init(bullet_pos.global_position, owner.rotation_degrees)
		get_tree().get_root().add_child(new_bullet)
		anim_player.play("shoot")
