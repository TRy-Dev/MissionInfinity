extends Node

var rng = RandomNumberGenerator.new()

func _init():
	rng.randomize()

func randf(from = 0.0, to = 1.0):
	return rng.randf_range(from, to)

func randi(from = 0, to = 1):
	return rng.randi_range(from, to)
