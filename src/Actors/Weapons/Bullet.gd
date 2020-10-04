extends PhysicsObject2D


onready var death_timer = $DeathTimer
onready var collision_area = $Collision

export(float, 0.0, 1000.0) var start_speed
export(float, 0.0, 100.0) var min_damage = 0.0
export(float, 1.0, 100.0) var max_damage = 1.0
export(float, 1.0, 5.0) var crit_damage_mult = 1.0

export(String) var spawn_sound = ""

const MIN_SPEED = 1.0
const ALIVE_DURATION = 10.0
const ENV_COLLISION_MASK = 1
var min_speed_squared = pow(MIN_SPEED, 2)

var bullet_layer = -1
var collision_masks = []

func init(pos, rot_deg, _bullet_layer, _collision_masks) -> void:
	rotation_degrees = rot_deg
	global_position = pos
	var rot_rad = deg2rad(rot_deg)
	velocity = Vector2(cos(rot_rad), sin(rot_rad)).normalized() * start_speed
	SfxController.play(spawn_sound)

	bullet_layer = _bullet_layer
	collision_masks = _collision_masks

func _ready() -> void:
	death_timer.wait_time = ALIVE_DURATION
	death_timer.start()
	collision_area.set_collision_layer_bit(bullet_layer, true)
	for cl in collision_masks:
		collision_area.set_collision_mask_bit(cl, true)

func _physics_process(delta):
	update()
	if velocity.length_squared() < min_speed_squared:
		die()

func die() -> void:
	queue_free()

func _on_Collision_area_entered(area):
#	print("Bullet collision with: %s - %s" % [area.name, area])
	die()

func _on_Collision_body_entered(body):
#	print("Bullet collision with: %s - %s" % [body.name, body])
	if body.get_collision_layer_bit(ENV_COLLISION_MASK):
		die()

func _on_DeathTimer_timeout():
	die()

func get_damage():
	return RNG.randf(min_damage, max_damage)

func get_critical_damage():
	return get_damage() * crit_damage_mult

