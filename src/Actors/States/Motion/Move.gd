extends State

var move_speed = 500.0

func enter(previous):
	owner.play_anim("move")

func update():
	var input = owner.get_input()
	if input == Vector2.ZERO:
		emit_signal("finished", "Idle")
	else:
		if owner.is_dashing():
			emit_signal("finished", "Dash")
			return
		owner.move(input.normalized() * move_speed)
