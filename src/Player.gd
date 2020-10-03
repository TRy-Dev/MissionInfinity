extends KinematicBody2D

onready var anim_player :AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	$StateMachine.initialize()

func move(vel: Vector2, speed_mult := 1.0) -> void:
	move_and_slide(vel * speed_mult)

func get_input() -> Vector2:
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(x, y)

func is_dashing() -> bool:
	return Input.is_action_just_pressed("dash")

func play_anim(name) -> void:
	if anim_player.has_animation(name):
		if anim_player.current_animation != name:
			anim_player.play(name)
	else:
		print("HEY! Unknown animation for player: %s" % name)

