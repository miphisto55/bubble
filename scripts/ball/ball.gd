class_name Ball
extends RigidBody2D

@export var ball_collision_shape: CollisionShape2D
@export var ball_sprite: Sprite2D
@export var ball_material: Resource

var colour_map: Dictionary = {
	Enums.BALL_COLOUR.ORANGE: Color(0.94,0.52,0.27,1.0),
	Enums.BALL_COLOUR.YELLOW: Color(0.97,0.81,0.31,1.0),
	Enums.BALL_COLOUR.GREEN: Color(0.44,0.97,0.31,1.0),
	Enums.BALL_COLOUR.SKY_BLUE: Color(0.31,0.87,0.97,1.0),
	Enums.BALL_COLOUR.DEEP_BLUE: Color(0.23,0.27,0.80,1.0),
	Enums.BALL_COLOUR.DEEP_PURPLE: Color(0.53,0.22,0.76,1.0),
	Enums.BALL_COLOUR.PINK: Color(0.89,0.43,0.90,1.0),
	Enums.BALL_COLOUR.RED: Color(0.91,0.33,0.33,1.0),
}

var colour: Enums.BALL_COLOUR
 
func _ready():
	ball_sprite.material = ball_material.duplicate()
	self.sleeping_state_changed.emit()
	colour = Enums.BALL_COLOUR.GREEN
	ball_sprite.material.set_shader_parameter("colour", colour_map[colour])

func apply_force_on_ball(vector: Vector2):
	apply_central_impulse(vector)
	SignalManager.ball_shot.emit()

func set_colour(value: Enums.BALL_COLOUR):
	colour = value
	ball_sprite.material.set_shader_parameter("colour", colour_map[colour])
	
func lock_ball():
	self.freeze_mode = RigidBody2D.FREEZE_MODE_STATIC
	self.linear_velocity = Vector2.ZERO
	self.sleeping = true
	set_deferred("lock_rotation", true) 
	set_deferred("freeze", true)
	self.sleeping_state_changed.emit()
	SignalManager.ball_locked.emit(self)

func _on_body_entered(body):
	if body.is_in_group("ceiling") or body.is_in_group("ball"):
		lock_ball()
