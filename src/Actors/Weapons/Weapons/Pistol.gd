extends Weapon

export var GODOT_INHERITED_EXPORT_BUG = "BUG"

func shoot() -> void:
	if can_shoot():
		if decrease_magazine_ammo(1):
			fire_rate_timer.start()
			spawn_bullet(bullet_pos.global_position, owner.rotation_degrees)
			anim_player.play("shoot")
		else:
			reload()
