extends Position2D

#onready var weapon = $Weapon

var current_weapon = null

func add_weapon(w) -> void:
	add_child(w)
	w.position.x = 15.0
	w.owner = self
	current_weapon = w

func update_rotation() -> void:
	var rot_rad = (get_global_mouse_position() - global_position).angle()
	rotation_degrees = rad2deg(rot_rad)
	if abs(rotation_degrees) > 90.0:
		current_weapon.flip(true)
	else:
		current_weapon.flip(false)

func shoot() -> void:
	current_weapon.shoot()
