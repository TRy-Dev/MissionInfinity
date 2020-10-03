extends PhysicsObject2D

class_name Actor

onready var anim_player :AnimationPlayer = $AnimationPlayer
onready var weapon_controller = $WeaponController
onready var sprite = $BodyPivot/Sprite

func _ready() -> void:
	$StateMachine.initialize()
	$Hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")
	$Hurtbox.connect("body_entered", self, "_on_Hurtbox_body_entered")

func update() -> void:
	.update()
	if velocity.x > 0 and sprite.flip_h:
		sprite.flip_h = false
	elif velocity.x < 0 and not sprite.flip_h:
		sprite.flip_h = true

func get_input() -> Vector2:
	return Vector2()

func play_anim(name) -> void:
	if anim_player.has_animation(name):
		if anim_player.current_animation != name:
			anim_player.play(name)
	else:
		print("HEY! Unknown animation for player: %s" % name)

func _on_Hurtbox_area_entered(area) -> void:
	print("Area %s entered %s Hurtbox" % [area.name, name])
	
func _on_Hurtbox_body_entered(body) -> void:
#	print("Body %s entered %s Hurtbox" % [body.name, name])
	pass

