extends Label

onready var start_position = rect_position


func _physics_process(_delta):
	rect_position = $"../BodyPivot".position + start_position


func _on_StateMachine_state_changed(current_state, previous_state):
	if current_state:
		text = current_state.get_name()
