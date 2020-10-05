extends Node2D



const CHUNK_SIZE = 1000

func _ready():
#	$WorldChunk.generate()
	$CanvasModulate.visible = true

func generate(x_size: int, y_size: int):
	for y in range(y_size):
		for x in range(x_size):
			pass
