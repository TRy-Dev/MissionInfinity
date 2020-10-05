extends Node2D

export(PackedScene) var enemy_prefab
export(float, 1.0, 100.0) var cooldown = 1.0
export(int, 1, 100) var enemies_spawned_count = 1

func _ready():
	if not enemy_prefab:
		return
	$Timer.wait_time = cooldown
	_spawn_enemy()
	$Sprite.visible = false

func _spawn_enemy():
	if enemies_spawned_count < 1:
		die()
		return
	var new_enemy = enemy_prefab.instance()
	# Parenting to YSort
	get_parent().call_deferred("add_child", new_enemy)
	new_enemy.global_position = global_position
	new_enemy.connect("actor_died", self, "_on_enemy_died")
	enemies_spawned_count -= 1

func die():
	queue_free()

func _on_enemy_died(enemy):
	$Timer.start()


func _on_Timer_timeout():
	_spawn_enemy()
