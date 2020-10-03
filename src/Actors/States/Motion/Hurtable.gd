extends State

class_name Hurtable

func _ready() -> void:
	owner.connect("actor_hurt", self, "_on_owner_hurt")
	owner.connect("actor_died", self, "_on_owner_died")

func _on_owner_hurt(current_health, amount):
	emit_signal("finished", "Hurt")
	
func _on_owner_died(owner):
	emit_signal("finished", "Die")
