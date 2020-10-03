extends Node
# Base interface for all states: it doesn't do anything by itself,
# but forces us to pass the right arguments to the methods below
# and makes sure every State object had all of these methods.

class_name State

# warning-ignore:unused_signal
signal finished(next_state_name)

# Initialize the state. E.g. change the animation.
func enter(previous):
#	print("From " + (previous.name if previous else " NULL") + " ntered " + name)
	pass


# Clean up the state. Reinitialize values like a timer.
func exit():
	pass


func update():
	owner.update()


func _on_animation_finished(_anim_name):
	pass
