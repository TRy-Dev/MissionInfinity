extends Area2D

var enabled = true


func enable():
	enabled = true


func _on_body_entered(body):
	print("body entered end goal %s" % body.name)
	if enabled:
		enabled = false
		GameController.mission_finished()
