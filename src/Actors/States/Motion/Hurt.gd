extends State

onready var timer = $Timer
export(String) var hurt_sound = ""

func enter(previous):
	SfxController.play(hurt_sound)
	timer.start()
	owner.play_anim("hurt")

func _on_Timer_timeout():
	emit_signal("finished", "previous")
