extends State


func enter(previous):
	owner.play_anim("idle")
#	print("From " + (previous.name if previous else " NULL") + " ntered " + name)
	pass

#
#func exit():
#	pass

func update():
	var input = owner.get_input()
	if input != Vector2.ZERO:
		owner.move(input.normalized())
		emit_signal("finished", "Move")
#	owner.update()
