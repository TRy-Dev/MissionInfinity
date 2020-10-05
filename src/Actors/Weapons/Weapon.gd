extends Node2D

class_name Weapon

signal ammo_used(ammo, amount)
signal reloaded(ammo, magazine_ammo)
signal started_reload()

onready var fire_rate_timer = $FireRate
onready var reload_timer = $Reload
onready var bullet_pos = $BulletPos
onready var anim_player :AnimationPlayer = $AnimationPlayer
onready var sprite = $Sprite

export(int, 0, 40) var pivot_length = 20
export(float, 0.1, 1.0) var fire_rate = 0.1
export(float, 0.1, 5.0) var reload_time = 0.5
export(PackedScene) var bullet_prefab
export(int, 0, 10000) var start_ammo = 10
export(int, 1, 100) var magazine_capacity = 3

var start_bullet_pos_y
var bullet_collision_masks = []
var bullet_layer

var ammo = 0
var magazine_ammo = 0

func _ready():
	fire_rate_timer.wait_time = fire_rate
	reload_timer.wait_time = reload_time
	start_bullet_pos_y = bullet_pos.position.y
	ammo = start_ammo
	reload()

func flip(val: bool) -> void:
	sprite.flip_v = val
	if val:
		bullet_pos.position.y = -1 * start_bullet_pos_y
	else:
		bullet_pos.position.y = start_bullet_pos_y

func shoot() -> void:
	print("HEY! Implement weapon shooting: %s" %name)

func set_collision_masks(layer, masks):
	bullet_layer = layer
	bullet_collision_masks = masks

func spawn_bullet(pos, rot):
	var new_bullet = bullet_prefab.instance()
	new_bullet.init(pos, rot, bullet_layer, bullet_collision_masks)
	get_tree().get_root().add_child(new_bullet)

func decrease_magazine_ammo(amount) -> bool:
	if magazine_ammo >= amount:
		magazine_ammo -= amount
		emit_signal("ammo_used", magazine_ammo, amount)
		return true
	return false

func reload():
	if ammo < 1 or magazine_ammo >= magazine_capacity:
		return
	reload_timer.start()
	emit_signal("started_reload")
	yield(reload_timer, "timeout")
	var left_ammo = min(ammo, magazine_capacity)
	ammo -= left_ammo - magazine_ammo
	magazine_ammo = left_ammo
	emit_signal("reloaded", ammo, magazine_ammo)

func can_shoot() -> bool:
	return reload_timer.is_stopped() and fire_rate_timer.is_stopped() and bullet_prefab
