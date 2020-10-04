extends Actor


func get_input() -> Vector2:
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(x, y)

func is_dashing() -> bool:
	return Input.is_action_just_pressed("dash")

func get_weapon_rotation() -> float:
	var rot_rad = (get_global_mouse_position() - weapon_controller.global_position).angle()
	return rad2deg(rot_rad)

func update() -> void:
	.update()
	if Input.is_action_pressed("shoot"):
		weapon_controller.shoot()
