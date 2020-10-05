extends Node

var rng = RandomNumberGenerator.new()
#var noise = OpenSimplexNoise.new()

func _init():
	rng.randomize()
	
#	noise.seed = randi()
#	noise.period = 1.0

func randf(from = 0.0, to = 1.0) -> float:
	return rng.randf_range(from, to)

func randi(from = 0, to = 1) -> int:
	return rng.randi_range(from, to)

func randi_range() -> int:
	return rng.randi()

func randv(from = -1, to = 1) -> Vector2:
	return Vector2(self.randi(from, to), self.randi(from, to))

#func noise_t(x) -> float:
#	var y = OS.get_system_time_secs() % 100000
#	var n = noise.get_noise_2d(x, y)#(x, OS.get_system_time_msecs())
#	n = n * 2 - 1
#	return n
