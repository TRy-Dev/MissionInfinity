extends Weapon

export var GODOT_INHERITED_EXPORT_BUG = "BUG"

func shoot() -> void:
	if cooldown_timer.is_stopped() and bullet_prefab:
		cooldown_timer.start()
		spawn_bullet(bullet_pos.global_position, owner.rotation_degrees)
		anim_player.play("shoot")
