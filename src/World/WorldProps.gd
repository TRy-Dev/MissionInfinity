extends Node

var colliding_props = [
	preload("res://src/World/Props/Box.tscn")
]

func get_colliding_prop():
	return colliding_props[0].instance()
