extends Hurtable

export(String) var step_sfx = ""
export var accel = 60.0

onready var step_sound_timer = $StepSoundTimer

func enter(previous):
	owner.play_anim("move")
	SfxController.play(step_sfx)
	step_sound_timer.start()

func update():
	var input = owner.get_input()
	if input == Vector2.ZERO:
		emit_signal("finished", "Idle")
	else:
		if owner.is_dashing():
			emit_signal("finished", "Dash")
			return
		owner.apply_force(input.normalized() * accel)
	.update()

func exit():
	step_sound_timer.stop()

func _on_StepSoundTimer_timeout():
	SfxController.play(step_sfx)
