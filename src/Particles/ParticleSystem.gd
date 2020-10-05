extends Node

var particles = {
	"impact": preload("res://src/Particles/ImpactParticle.tscn"),
}

func spawn_particle(name, position) -> void:
	if name in particles:
		var p = particles[name].instance()
		p.init(position)
		get_tree().get_root().add_child(p)
	else:
		print("HEY! No such particle: %s" % name)
