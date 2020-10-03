extends Actor

func _ready():
#	weapon_controller.add_weapon(load("res://src/Actors/Weapons/Weapon.tscn").instance())
	pass

func get_input() -> Vector2:
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(x, y)

func is_dashing() -> bool:
	return Input.is_action_just_pressed("dash")

func update() -> void:
	weapon_controller.update_rotation()
	if Input.is_action_pressed("shoot"):
		weapon_controller.shoot()
	.update()
