extends PhysicsObject2D

class_name Actor

signal actor_hurt(current_health, amount)
signal actor_died(actor)

export(PackedScene) var start_weapon
export(String) var _type = "Actor"
export(String) var hurt_sound = ""
export(String) var crit_hurt_sound = ""

onready var anim_player :AnimationPlayer = $AnimationPlayer
onready var weapon_controller = $WeaponController
#onready var sprite = $BodyPivot/Sprite
onready var sprites = [
	$BodyPivot/Movable/Idle,
	$BodyPivot/Movable/Move,
	$BodyPivot/Movable/Dash,
]

const MAX_HEALTH = 100.0
var health = MAX_HEALTH
var dead = false
var immune = false

func _ready() -> void:
	$StateMachine.initialize()
	$Hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")
	$Hurtbox.connect("body_entered", self, "_on_Hurtbox_body_entered")
	$HurtboxCritical.connect("area_entered", self, "_on_CritialHurtbox_area_entered")
	$HurtboxCritical.connect("body_entered", self, "_on_CritialHurtbox_body_entered")
	modulate.a = 0.0
#	play_anim("spawn")

# Some things have to be loaded later for UI
func late_ready() -> void:
	if start_weapon:
		add_weapon(start_weapon.instance())

func add_weapon(w) -> void:
	$WeaponController.add_weapon(w)
	w.connect("started_reload", self, "_on_weapon_started_reload")
	w.connect("reloaded", self, "_on_weapon_reloaded")

func update() -> void:
	.update()
	_set_sprite_orientation()
	weapon_controller.update_rotation(get_weapon_rotation())

func _set_sprite_orientation():
	if velocity.x > 0 and sprites[0].flip_h:
		for s in sprites:
			s.flip_h = false
	elif velocity.x < 0 and not sprites[0].flip_h:
		for s in sprites:
			s.flip_h = true

func get_input() -> Vector2:
	return Vector2()

func get_weapon_rotation() -> float:
	return 0.0

func is_dashing() -> bool:
	return false

func play_anim(name) -> void:
	if anim_player.current_animation == "die":
		print("HEY! died already!")
		return
	if anim_player.has_animation(name):
		if anim_player.current_animation == name:
			return
		if anim_player.current_animation in ["spawn", "hurt"]:
			anim_player.queue("_reset")
			anim_player.queue(name)
		else:
			anim_player.play("_reset")
			anim_player.queue(name)
	else:
		print("HEY! Unknown animation for actor: %s" % name)

func damage(amount: int, critical = false) -> void:
	if amount < 0:
		print("HEY! Trying to heal? Negative damage amount: %s" % amount)
		return
	if immune:
		return
	health -= amount
	if amount > 0:
		emit_signal("actor_hurt", health, amount)
	if health <= 0:
		health = 0
		die()
	if critical:
		SfxController.play(crit_hurt_sound)
	else:
		SfxController.play(hurt_sound)
	

func die() -> void:
	if dead:
		return
	_disable_collisions(true, true)
	emit_signal("actor_died", self)
	play_anim("die")
	dead = true
#	$KillTimer.start()
	yield(anim_player, "animation_finished")
	queue_free()

func is_type(type):
	return type == _type or .is_type(type)
func get_type():
	return _type

func get_center() -> Vector2:
	return weapon_controller.global_position

func set_immune(val: bool, self_exit = false) -> void:
	immune = val
	_disable_collisions(val, false)
	if self_exit and val:
		$ImmuneDisabler.start()

func _disable_collisions(val: bool, set_world_collision = false) -> void:
	$Hurtbox/CollisionShape2D.set_deferred("disabled", val)
	$HurtboxCritical/CollisionShape2D.set_deferred("disabled", val)
	if set_world_collision:
		$CollisionShape2D.set_deferred("disabled", val)

func _on_Hurtbox_area_entered(area) -> void:
	if not dead:
		damage(area.owner.get_damage())
#	print("Area %s entered %s Hurtbox" % [area.name, name])
	
func _on_Hurtbox_body_entered(body) -> void:
#	print("Body %s entered %s Hurtbox" % [body.name, name])
	pass

func _on_CritialHurtbox_area_entered(area) -> void:
	if not dead:
		damage(area.owner.get_critical_damage(), true)

func _on_CritialHurtbox_body_entered(body) -> void:
	pass

func _on_weapon_started_reload():
#	print("Weapon started reload for: %s" % name)
	pass

func _on_weapon_reloaded(ammo, magazine_ammo):
#	print("Weapon reloaded for: %s" % name)
	pass

func on_dash():
	pass


func _on_ImmuneDisabler_timeout():
	set_immune(false)


func _on_KillTimer_timeout():
	queue_free()
