extends Actor

export(float, 0.0, 30.0) var aim_precision = 0.0
export(float, 20.0, 300.0) var see_range = 250.0
export(float, 20.0, 300.0) var shoot_range = 150.0

onready var see_shape = $PlayerDetect/CollisionShape2D
onready var shoot_shape = $ShootRange/CollisionShape2D

var ai_input := Vector2()
var target = null

var target_in_shooting_range = false

var unique_noise_id = -1

const TARGET_VEL_MULT = 0.3

func _ready() -> void:
	see_shape.shape.radius = see_range
	shoot_shape.shape.radius = shoot_range
	$HealthBar._on_max_health_updated(health)
	connect("actor_hurt", $HealthBar, "_on_health_bar_updated")
	$AI.initialize()
	unique_noise_id = RNG.randi_range()
	late_ready()

func get_input() -> Vector2:
	return ai_input

func is_dashing() -> bool:
	return false

func get_weapon_rotation() -> float:
	if target:
		var angle_rad = (target.get_center() + target.velocity * TARGET_VEL_MULT - weapon_controller.global_position).angle()
		var angle_deg = rad2deg(angle_rad) #+ RNG.noise_t(unique_noise_id) * aim_precision
		return angle_deg
	return 0.0

func set_input(val: Vector2) -> void:
	ai_input = val

func shoot():
	if not immune:
		weapon_controller.shoot()

func _on_PlayerDetect_body_entered(body):
	target = body

func _on_PlayerDetect_body_exited(body):
	target = null
	target_in_shooting_range = false

func _on_ShootRange_body_entered(body):
	target_in_shooting_range = true

func _on_ShootRange_body_exited(body):
	target_in_shooting_range = false
