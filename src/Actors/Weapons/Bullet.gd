extends Area2D

onready var death_timer = $DeathTimer

export var speed = 500
export var accel = -100.0

const MIN_SPEED = 1.0
const ALIVE_DURATION = 10.0

var dir = Vector2()

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
	print("Bullet collision with: %s - %s" % [area.name, area])

func _on_DeathTimer_timeout():
	die()
