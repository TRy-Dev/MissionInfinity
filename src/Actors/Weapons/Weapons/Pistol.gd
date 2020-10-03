extends Weapon

func shoot() -> void:
	if cooldown_timer.is_stopped() and bullet_prefab:
		cooldown_timer.start()
		var new_bullet = bullet_prefab.instance()
		new_bullet.init(bullet_pos.global_position, owner.rotation_degrees)
		get_tree().get_root().add_child(new_bullet)
		anim_player.play("shoot")
