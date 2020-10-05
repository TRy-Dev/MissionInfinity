extends State

onready var timer = $Timer

export var dash_time = 0.2
export var dash_force = 150
var dir := Vector2()

func enter(previous):
	owner.play_anim("dash")
	owner.set_immune(true)
	owner.on_dash()
	dir = owner.get_input().normalized()
	timer.start(dash_time)
	SfxController.play("dash")

func update():
	owner.apply_force(dir * dash_force)
	.update()

func exit():
	owner.set_immune(false)

func _on_Timer_timeout():
	emit_signal("finished", "previous")
