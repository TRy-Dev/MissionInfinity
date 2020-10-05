extends State

onready var timer = $Timer
export(String) var hurt_sound = ""
export(float, 0.001, 1.0) var hurt_duration = 0.001

func _ready():
	timer.wait_time = hurt_duration

func enter(previous):
	SfxController.play(hurt_sound)
	timer.start()
	owner.play_anim("hurt")
	owner.set_immune(true, true)

func _on_Timer_timeout():
	emit_signal("finished", "previous")

#func exit():
#	owner.set_immune(false)
