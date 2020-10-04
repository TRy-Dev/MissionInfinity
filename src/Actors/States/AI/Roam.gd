extends State

onready var timer = $Timer

export(float, 0.0, 1.0) var prob_stop = 0.5
export(float, 0.0, 1.0) var prob_change_dir = 0.3

func enter(previous):
	timer.start()

func update():
	if owner.target:
		emit_signal("finished", "Chase")
	# Do not propagate to State.update() - enemy will update twice

func exit():
	timer.stop()

func _on_Timer_timeout():
	if RNG.randf() < prob_stop:
		owner.set_input(Vector2(0, 0))
	elif RNG.randf() < prob_change_dir:
		owner.set_input(RNG.randv())
	else:
		# same direction
		pass

