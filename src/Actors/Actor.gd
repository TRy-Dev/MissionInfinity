extends PhysicsObject2D

class_name Actor

signal actor_hurt(current_health, amount)
signal actor_died(actor)

export(PackedScene) var start_weapon
export(String) var _type = "Actor"

onready var anim_player :AnimationPlayer = $AnimationPlayer
onready var weapon_controller = $WeaponController
onready var sprite = $BodyPivot/Sprite

var health = 100.0
var dead = false
var immune = false

func _ready() -> void:
	$StateMachine.initialize()
	$Hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")
	$Hurtbox.connect("body_entered", self, "_on_Hurtbox_body_entered")
	$HurtboxCritical.connect("area_entered", self, "_on_CritialHurtbox_area_entered")
	$HurtboxCritical.connect("body_entered", self, "_on_CritialHurtbox_body_entered")
	connect("actor_hurt", $HealthBar, "_on_health_bar_updated")
	$HealthBar._on_max_health_updated(health)
	$WeaponController.add_weapon(start_weapon)
	
	modulate.a = 0.0
	play_anim("spawn")

func update() -> void:
	.update()
	if velocity.x > 0 and sprite.flip_h:
		sprite.flip_h = false
	elif velocity.x < 0 and not sprite.flip_h:
		sprite.flip_h = true
	weapon_controller.update_rotation(get_weapon_rotation())

func get_input() -> Vector2:
	return Vector2()

func get_weapon_rotation() -> float:
	return 0.0

func is_dashing() -> bool:
	return false

func play_anim(name) -> void:
	if anim_player.has_animation(name):
		if anim_player.current_animation == "spawn":
			anim_player.queue(name)
		elif anim_player.current_animation != name:
			anim_player.play(name)
	else:
		print("HEY! Unknown animation for actor: %s" % name)

func damage(amount: int) -> void:
	if immune:
		return
	health -= amount
	if amount > 0:
		emit_signal("actor_hurt", health, amount)
	if health <= 0:
		health = 0
		die()
#	else:
	

func die() -> void:
	if dead:
		return
	_disable_collisions()
	emit_signal("actor_died", self)
	play_anim("die")
	dead = true
	yield(anim_player, "animation_finished")
	queue_free()

func is_type(type):
	return type == _type or .is_type(type)
func get_type():
	return _type

func get_center() -> Vector2:
	return weapon_controller.global_position

func _disable_collisions():
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)

func _on_Hurtbox_area_entered(area) -> void:
	if not dead:
		damage(area.owner.get_damage())
#	print("Area %s entered %s Hurtbox" % [area.name, name])
	
func _on_Hurtbox_body_entered(body) -> void:
#	print("Body %s entered %s Hurtbox" % [body.name, name])
	pass

func _on_CritialHurtbox_area_entered(area) -> void:
	if not dead:
		damage(area.owner.get_critical_damage())

func _on_CritialHurtbox_body_entered(body) -> void:
	pass
