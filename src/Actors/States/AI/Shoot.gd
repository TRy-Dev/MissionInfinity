extends State

func enter(previous):
	owner.set_input(Vector2.ZERO)

func update():
	if owner.target_in_shooting_range:
		owner.shoot()
	else:
		emit_signal("finished", "Chase")
	# Do not propagate to State.update() - enemy will update twice
