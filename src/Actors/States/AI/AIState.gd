extends State

class_name AIState

func update():
	if owner.dead:
		emit_signal("finished", "Die")
