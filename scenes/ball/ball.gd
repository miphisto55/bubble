extends RigidBody2D


func apply_force_on_ball(vector: Vector2):
	apply_central_impulse(vector)
