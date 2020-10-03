extends State

onready var timer = $Timer

var dash_time = 0.2
var dash_distance = 300
var dir := Vector2()

func enter(previous):
	owner.play_anim("dash")
	dir = owner.get_input().normalized()
	timer.start(dash_time)

func update():
	owner.move(dir * dash_distance / dash_time)

func _on_Timer_timeout():
	emit_signal("finished", "Move")
