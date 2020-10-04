extends KinematicBody2D

class_name PhysicsObject2D

export(float, 0.01, 100.0) var mass = 1.0
var velocity = Vector2()
var acceleration = Vector2()
export(float, 0.0, 1.0) var friction_coeff = 0.4

func apply_force(force: Vector2):
	acceleration += force / mass

func update():
	var friction = Vector2(velocity.x, velocity.y)
	friction *= -1
	friction = friction.normalized()
	friction *= friction_coeff * velocity.length()
	apply_force(friction)
	
	velocity += acceleration;
	velocity = move_and_slide(velocity);
	acceleration = Vector2()
