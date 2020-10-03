extends Hurtable


func enter(previous):
	owner.play_anim("idle")

func update():
	var input = owner.get_input()
	if input != Vector2.ZERO:
		emit_signal("finished", "Move")
	.update()
