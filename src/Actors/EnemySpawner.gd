extends Node2D

export(PackedScene) var enemy_prefab
export(float, 1.0, 100.0) var cooldown = 1.0

func _ready():
	if not enemy_prefab:
		return
	$Timer.wait_time = cooldown
	_spawn_enemy()

func _spawn_enemy():
	var new_enemy = enemy_prefab.instance()
	add_child(new_enemy)
	new_enemy.global_position = global_position
	new_enemy.connect("actor_died", self, "_on_enemy_died")


func _on_enemy_died(enemy):
	$Timer.start()


func _on_Timer_timeout():
	_spawn_enemy()
