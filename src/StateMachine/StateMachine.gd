extends Node
# Base interface for a generic state machine.
# It handles initializing, setting the machine active or not
# delegating _physics_process, _input calls to the State nodes,
# and changing the current/active state.
# See the PlayerV2 scene for an example on how to use it.

signal state_changed(current_state, previous_state)

# You should set a starting node from the inspector or on the node that inherits
# from this state machine interface. If you don't, the game will default to
# the first state in the state machine's children.
export(NodePath) var start_state

var states_map = {}

var states_stack = []
var current_state = null
var _active = false setget set_active

func _init() -> void:
	set_physics_process(false)
	set_process_input(false)


func initialize():
	for c in get_children():
		states_map[c.name] = c
	if not start_state:
		start_state = get_child(0).get_path()
	for child in get_children():
		child.connect("finished", self, "_change_state")
	set_active(true)
	states_stack.push_front(get_node(start_state))
	if states_stack[0]:
		_change_state(states_stack[0].name)
	else:
		print("HEY! Cant initialize FSM %s on %s." % [name, owner.name])
		set_active(false)
#	current_state = states_stack[0]
#	current_state.enter(null)


func set_active(value):
	_active = value
	set_physics_process(value)
	set_process_input(value)
	if not _active:
		states_stack = []
		current_state = null


func _physics_process(delta):
	current_state.update()


func _on_animation_finished(anim_name):
	if not _active:
		return
	current_state._on_animation_finished(anim_name)


func _change_state(state_name):
	if not _active:
		return
	var current_name = ""
	if current_state:
		current_name = current_state.name
		if current_name.to_upper() == state_name.to_upper():
			return
		current_state.exit()

	var previous = current_state

	if state_name == "previous":
		states_stack.pop_front()
	else:
		if not state_name in states_map:
			print("HEY! No such fsm state: %s" % state_name)
			return
		states_stack.push_front(states_map[state_name])
#		states_stack[0] = states_map[state_name]
	current_state = states_stack[0]
#	states_stack.push_front(current_state)
	emit_signal("state_changed", current_state, current_name)

#	if state_name != "previous":
	current_state.enter(previous)
