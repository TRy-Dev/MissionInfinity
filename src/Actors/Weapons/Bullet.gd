extends Area2D

onready var death_timer = $DeathTimer

export var speed = 500
export var accel = -100.0
export(float, 1.0, 100.0) var min_damage = 25.0
export(float, 1.0, 100.0) var max_damage = 40.0

const MIN_SPEED = 1.0
const ALIVE_DURATION = 10.0

var dir = Vector2()

const ENV_COLLISION_MASK = 1

func init(pos, rot_deg) -> void:
	rotation_degrees = rot_deg
	global_position = pos
	var rot_rad = deg2rad(rot_deg)
	dir = Vector2(cos(rot_rad), sin(rot_rad))
	speed = max(speed, MIN_SPEED)
	SfxController.play("bullet")

func _ready() -> void:
	death_timer.wait_time = ALIVE_DURATION
	death_timer.start()

func _physics_process(delta):
	global_position += speed * dir * delta
	speed += accel * delta
	if speed < MIN_SPEED:
		die()

func die() -> void:
	queue_free()

func _on_area_entered(area):
#	print("Bullet collision with: %s - %s" % [area.name, area])
	die()

func _on_body_entered(body):
	if body.get_collision_layer_bit(ENV_COLLISION_MASK):
		die()

func _on_DeathTimer_timeout():
	die()

func get_damage():
	return RNG.randf(min_damage, max_damage)

