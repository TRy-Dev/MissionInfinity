extends Position2D

var current_weapon = null

func add_weapon(weapon) -> void:
	if not weapon:
		return
	weapon = weapon.instance()
	add_child(weapon)
	weapon.position.x = weapon.pivot_length
	weapon.owner = self
	current_weapon = weapon

func update_rotation() -> void:
	if not current_weapon:
		return
	var rot_rad = (get_global_mouse_position() - global_position).angle()
	rotation_degrees = rad2deg(rot_rad)
	if abs(rotation_degrees) > 90.0:
		current_weapon.flip(true)
	else:
		current_weapon.flip(false)

func shoot() -> void:
	if current_weapon:
		current_weapon.shoot()
