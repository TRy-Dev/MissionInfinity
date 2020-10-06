extends Weapon

export(int, 2, 18) var bullets = 3
export(float, 0.0, 180.0) var spread_angle = 30.0
export var GODOT_INHERITED_EXPORT_BUG = "BUG"

func shoot() -> void:
	if can_shoot():
		if decrease_magazine_ammo(bullets):
			var start_angle = owner.rotation_degrees - spread_angle
			var delta_angle = 2.0 * spread_angle / (bullets - 1)
			for i in range(bullets):
				spawn_bullet(bullet_pos.global_position, start_angle + delta_angle * i)
			fire_rate_timer.start()
			if pivot_length > 0:
				anim_player.play("shoot")
		else:
			reload()
	.shoot()
