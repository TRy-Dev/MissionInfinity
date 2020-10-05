extends Position2D

signal weapon_equipped(weapon)

var current_weapon = null

const PLAYER_BULLET_MASKS = [1,2,4]
const PLAYER_BULLET_LAYER = 3
const ENEMY_BULLET_MASKS = [0,1,3]
const ENEMY_BULLET_LAYER = 4

func add_weapon(weapon) -> void:
	unequip_current()
	if not weapon:
		return
	add_child(weapon)
	weapon.position.x = weapon.pivot_length
	weapon.owner = self
	current_weapon = weapon
	
	var owner_type = owner.get_type()
	if owner_type == "Player":
		weapon.set_collision_masks(PLAYER_BULLET_LAYER, PLAYER_BULLET_MASKS)
	elif owner_type == "Enemy":
		weapon.set_collision_masks(ENEMY_BULLET_LAYER, ENEMY_BULLET_MASKS)
	else:
		print("HEY! Unknown owner for weapon controller: %s" % owner_type)
	emit_signal("weapon_equipped", weapon)

func unequip_current():
	if current_weapon:
		print("TODO: Unequipping current weapon %s" % current_weapon.name)

func update_rotation(rot) -> void:
	if not current_weapon:
		return
	rotation_degrees = rot
	if abs(rotation_degrees) > 90.0:
		current_weapon.flip(true)
	else:
		current_weapon.flip(false)

func shoot() -> void:
	if current_weapon:
		current_weapon.shoot()

func reload() -> void:
	current_weapon.reload()
