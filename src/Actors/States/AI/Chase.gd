extends State

func update():
	if not owner.target:
		emit_signal("finished", "Roam")
	elif owner.target_in_shooting_range:
		emit_signal("finished", "Shoot")
		owner.set_input(Vector2.ZERO)
		pass
	else:
		var dir = (owner.target.global_position - owner.global_position).normalized()
		owner.set_input(dir)
	# Do not propagate to State.update() - enemy will update twice
