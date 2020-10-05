extends YSort

onready var small_props_from = $SmallPropsFrom
onready var small_props_to = $SmallPropsTo

const NUM_SMALL_PROPS = 50

var small_props = [
	preload("res://src/World/Props/Rock1.tscn"),
	preload("res://src/World/Props/Rock3.tscn"),
	preload("res://src/World/Props/Rock4.tscn"),
	preload("res://src/World/Props/Rock6.tscn"),
	preload("res://src/World/Props/Sand1.tscn"),
	preload("res://src/World/Props/Sand2.tscn"),
]

func _ready():
	generate_small_props()


func generate_small_props():
	for i in range(NUM_SMALL_PROPS):
		var pos = RNG.randvv(small_props_from.global_position, small_props_to.global_position)
		var rand_prop = small_props[RNG.randi(0, len(small_props) - 1)]
		var inst = rand_prop.instance()
		inst.global_position = pos
		add_child(inst)
		
