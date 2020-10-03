extends PhysicsObject2D

class_name Actor

signal actor_hurt(current_health, amount)
signal actor_died(actor)

export(PackedScene) var start_weapon

onready var anim_player :AnimationPlayer = $AnimationPlayer
onready var weapon_controller = $WeaponController
onready var sprite = $BodyPivot/Sprite

var health = 100.0
var dead = false

func _ready() -> void:
	$StateMachine.initialize()
	$Hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")
	$Hurtbox.connect("body_entered", self, "_on_Hurtbox_body_entered")
	connect("actor_hurt", $HealthBar, "_on_health_bar_updated")
	$HealthBar._on_max_health_updated(health)
	$WeaponController.add_weapon(start_weapon)

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
		print("HEY! Unknown animation for actor: %s" % name)

func damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		health = 0
		die()
	else:
		emit_signal("actor_hurt", health, amount)

func die() -> void:
	if dead:
		return
	_disable_collisions()
	emit_signal("actor_died", self)
	play_anim("die")
	dead = true
	yield(anim_player, "animation_finished")
	queue_free()
	

func _disable_collisions():
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)

func _on_Hurtbox_area_entered(area) -> void:
	damage(area.get_damage())
#	print("Area %s entered %s Hurtbox" % [area.name, name])
	
func _on_Hurtbox_body_entered(body) -> void:
#	print("Body %s entered %s Hurtbox" % [body.name, name])
	pass

