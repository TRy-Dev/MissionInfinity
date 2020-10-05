extends Actor

signal stamina_updated(stamina)

onready var stamina_frozen_timer = $StaminaFrozenTimer
onready var dash_cooldown_timer = $DashCooldownTimer

const MAX_STAMINA = 100.0
const STAMINA_REGEN = 25.0
const DASH_COST = 45.0
var stamina = MAX_STAMINA

func _ready():
	$PlayerAnim.play("idle-light")

func get_input() -> Vector2:
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(x, y)

func is_dashing() -> bool:
	var can_dash = dash_cooldown_timer.is_stopped()
	can_dash = can_dash and stamina >= DASH_COST
	return Input.is_action_just_pressed("dash") and can_dash


func _set_sprite_orientation():
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.x > global_position.x and sprite.flip_h:
		sprite.flip_h = false
	elif mouse_pos.x < global_position.x and not sprite.flip_h:
		sprite.flip_h = true

func get_weapon_rotation() -> float:
	var rot_rad = (get_global_mouse_position() - weapon_controller.global_position).angle()
	return rad2deg(rot_rad)

func update() -> void:
	.update()
	if Input.is_action_pressed("shoot"):
		weapon_controller.shoot()
	elif Input.is_action_just_pressed("reload"):
		weapon_controller.reload()
	_update_stamina()

func _on_weapon_started_reload():
	SfxController.play("reload")

func _update_stamina():
	if stamina_frozen_timer.is_stopped():
		var new_stamina = min(MAX_STAMINA, stamina + STAMINA_REGEN * get_physics_process_delta_time())
		var delta = new_stamina - stamina
		stamina = new_stamina
		emit_signal("stamina_updated", stamina, delta)

func on_dash():
	stamina -= DASH_COST
	dash_cooldown_timer.start()
	stamina_frozen_timer.start()
	emit_signal("stamina_updated", stamina, DASH_COST)

func die():
	$PlayerAnim.play("died")
	.die()
